{ lib, ... }:

let
  inherit (import ./lua_utils.nix { inherit lib; })
    on_startup;
in {
  wayland.windowManager.hyprland.settings = {
    on = on_startup ''hl.exec_cmd("systemctl --user start hyprpaper")'';
  };
  
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = {
        monitor = "";
        path = "${../../images/illdian.png}";
      };
    };
  };
}
