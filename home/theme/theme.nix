{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    dconf

    # At least one of these is needed on a new system, but not after
    # Which one? who knows.
    # sassc
    # gtk-engine-murrine
    # gnome-themes-extra
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    gtk4.theme = config.gtk.theme;
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