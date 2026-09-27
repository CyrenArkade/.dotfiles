{ lib, pkgs, ... }:

let
  inherit (import ../hypr/lua_utils.nix { inherit lib; })
    bind exec;

  take-screenshot = pkgs.writeShellApplication {
    name = "take-screenshot";
    runtimeInputs = with pkgs; [ grabit libnotify xdg-utils ];
    text = builtins.readFile ./take-screenshot.sh;
  };
in {
  xdg.configFile."grabit/config.toml".source = (pkgs.formats.toml {}).generate "config.toml" {
    notifications = false;
    save_dir = "/tmp";
    filename_preset = "uuid";
    preview.enabled = true;
    edit = {
      instant_capture = true;
      swatches = "#f38ba8,#fab387,#f9e2af,#a6e3a1,#89b4fa,#b4befe";
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = map bind [
      ["mouse:276" (exec "${take-screenshot}/bin/take-screenshot")]
      ["print" (exec "${take-screenshot}/bin/take-screenshot")]
    ];
    layer_rule = [
      { match.namespace = "selection"; no_anim = true; }
    ];
  };
}
