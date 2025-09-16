{ inputs, config, pkgs, ... }:

{

  programs.vesktop = {
    enable = true;
    package = pkgs.vesktop.override {
      withMiddleClickScroll = true;
    };
  };

  xdg.configFile."vesktop/settings/quickCss.css".source = ./quick.css;
}