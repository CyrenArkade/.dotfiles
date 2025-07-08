{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hypredge.packages.${pkgs.system}.hypredge
    ];
    
    settings = {
      plugin = {
        hypredge = {
          # blacklist = [
          #   "class, code"
          # ];
          edge-effect = [
            "left, workspace, e-1"
            "left, hypredge:movecursortoedge, right"
            "right, workspace, e+1"
            "right, hypredge:movecursortoedge, left"
          ];
        };
      };
    };
  };
}