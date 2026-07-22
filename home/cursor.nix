{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "graphite-light";
    size = 24;
    package = pkgs.custom-cursor;
  };
}
