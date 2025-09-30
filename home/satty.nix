{ lib, pkgs, ... }:

let
  takeScreenshot = pkgs.writeShellScript "takeScreenshot" ''
    folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
    fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
    fullPath="$folderName/$fileName"

    mkdir -p "$folderName"
    ${pkgs.grim}/bin/grim -t ppm - | ${pkgs.satty}/bin/satty --filename - --output-filename "$fullPath"
  '';
in {
  xdg.configFile."satty/config.toml".source = (pkgs.formats.toml {}).generate "config.toml" {
    general = {
      fullscreen = true;
      corner-roundness = 0;
      initial-tool = "crop";
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
      ", mouse:276, exec, ${takeScreenshot}"
      ", Print, exec, ${takeScreenshot}" # printscreen
    ];
    windowrule = [
      "noanim, class:^(com.gabm.satty)$"
      # "float, class:^(com.gabm.satty)$"
      # "move 0 0, class:^(com.gabm.satty)$"
      # "pin, class:^(com.gabm.satty)$"
      # "size 100% 100%, class:^(com.gabm.satty)$"
      # "noinitialfocus, class:^(com.gabm.satty)$"
    ];
  };
}
