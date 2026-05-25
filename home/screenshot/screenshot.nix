{ lib, pkgs, ... }:

let
  inherit (import ../hypr/lua_utils.nix { inherit lib; })
    call bind_exec;

  take-screenshot = pkgs.writeShellApplication {
    name = "take-screenshot";
    runtimeInputs = with pkgs; [ still slurp grim libnotify satty xdg-utils ];
    text = builtins.readFile ./take-screenshot.sh;
  };
in {
  xdg.configFile."satty/config.toml".source = (pkgs.formats.toml {}).generate "config.toml" {
    general = {
      corner-roundness = 0;
      actions-on-enter = [ "save-to-clipboard" "save-to-file" "exit" ];
      actions-on-right-click = [ "exit" ];
      copy-command = "${pkgs.wl-clipboard}/bin/wl-copy";
      disable-notifications = true;
    };
    color-palette = {
      palette = [ "#f38ba8" "#fab387" "#f9e2af" "#a6e3a1" "#89dceb" "#89b4fa" "#b4befe" "#000000" "#ffffff" ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = map call [
      (bind_exec "mouse:276" "${take-screenshot}/bin/take-screenshot")
      (bind_exec "print" "${take-screenshot}/bin/take-screenshot")
    ];
    layer_rule = [
      { match.namespace = "selection"; no_anim = true; }
    ];
  };
}
