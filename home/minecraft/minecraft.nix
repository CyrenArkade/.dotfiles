{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalLibs = [ jemalloc ];
    })
    waywall
    ninjabrainbot
  ];

  xdg.configFile = {
    "waywall/init.lua".source = ./init.lua;
    "waywall/measuring_overlay.png".source = ./measuring_overlay.png;
  };
}
