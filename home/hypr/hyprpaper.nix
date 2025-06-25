{ lib, ... }:

let
  wallpaper = toString ../../images/xilmo2.jpg;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = wallpaper;
      wallpaper = " , ${wallpaper}";
    };
  };
}