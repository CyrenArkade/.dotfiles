{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sassc
    gtk-engine-murrine
    gnome-themes-extra
  ];
  
  gtk = {
    enable = true;
    theme = {
      name = "Graphite-Dark";
      package = pkgs.graphite-gtk-theme;
    };
  };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Catppuccin-GTK-Purple-Dark-Compact";
  #     package = pkgs.magnetic-catppuccin-gtk.override {
  #       accent = [ "purple" ];
  #       shade = "dark";
  #       size = "compact";
  #     };
  #   };
  # };
}