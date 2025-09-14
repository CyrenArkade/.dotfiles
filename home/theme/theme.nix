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
    gtk3.extraCss = (builtins.readFile ./gtk-colors.css);
    gtk4.extraCss = (builtins.readFile ./gtk-colors.css);
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
  catppuccin.kvantum.enable = true;
}