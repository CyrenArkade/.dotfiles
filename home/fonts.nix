{ pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Serif CJK JP" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
        monospace = [ "Noto Sans Mono" "Noto Sans Mono CJK JP" ];
      };
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.hack
    font-awesome

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}