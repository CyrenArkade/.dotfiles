{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hypredge.packages.${pkgs.system}.hypredge
    ];
    
    settings = {
      plugin = {
        overview = {
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