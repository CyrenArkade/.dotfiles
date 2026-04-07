{ lib, pkgs, ... }:

let
  take-screenshot = pkgs.writeShellApplication {
    name = "take-screenshot";
    runtimeInputs = with pkgs; [ local.still slurp grim libnotify satty xdg-utils ];
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
    bind = [
      ", mouse:276, exec, ${take-screenshot}/bin/take-screenshot"
      ", Print, exec, ${take-screenshot}/bin/take-screenshot" # printscreen
    ];
    layerrule = [
      "match:namespace selection, no_anim on"
    ];
  };
}
