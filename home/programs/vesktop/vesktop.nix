{ inputs, config, pkgs, ... }:

{

  programs.vesktop = {
    enable = true;
    package = pkgs.vesktop.override {
      withMiddleClickScroll = true;
    };
    vencord.extraQuickCss = builtins.readFile ./quick.css;
  };
}