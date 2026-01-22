{ lib, ... }:

let
  wallpaper = "${../../images/xiv2.png}";
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user start hyprpaper"
    ];
  };
  
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = wallpaper;
      wallpaper = " , ${wallpaper}";
    };
  };
}