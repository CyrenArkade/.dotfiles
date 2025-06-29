{ lib, ... }:

let
  wallpaper = toString ../../images/xilmo2.jpg;
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