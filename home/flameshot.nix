{ lib, pkgs, ... }:

let
  waylandFlameshot = (pkgs.flameshot.override { enableWlrSupport = true; });
  takeScreenshot = pkgs.writeShellScript "takeScreenshot" ''
    folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
    fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
    fullPath="$folderName/$fileName"

    mkdir -p "$folderName"
    QT_SCALE_FACTOR=0.8 ${waylandFlameshot}/bin/flameshot gui -p "$fullPath"
    pkill flameshot

    if [ -f "$fullPath" ]; then
      ${pkgs.wl-clipboard}/bin/wl-copy < "$fullPath"
    fi
  '';
in {

  # Settings aren't documented. To discover options, run `flameshot config`
  # while hm isn't managing flameshot.ini, then copy whatever it writes.
  xdg.configFile."flameshot/flameshot.ini".text = lib.generators.toINI {} {
    General = {
      contrastUiColor = "#b4befe";
      drawColor = "#b4befe";
      uiColor = "#1e1e2e";
      userColors = "picker, #f38ba8, #fab387, #f9e2af, #a6e3a1, #89dceb, #89b4fa, #b4befe, #000000, #ffffff";
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      ", mouse:276, exec, ${takeScreenshot}"
    ];
    windowrulev2 = [
      "noanim, class:^(flameshot)$"
      "float, class:^(flameshot)$"
      "move 0 0, class:^(flameshot)$"
      "pin, class:^(flameshot)$"
    ];
  };
}