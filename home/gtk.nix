{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dconf
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    gtk3.extraCss = (builtins.readFile ./gtk_colors.css);
    gtk4.extraCss = (builtins.readFile ./gtk_colors.css);
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