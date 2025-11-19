{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hypredge.packages.${pkgs.stdenv.hostPlatform.system}.hypredge
    ];
    
    settings = {
      plugin = {
        hypredge = {
          # blacklist = [
          #   "class, code"
          # ];
          respect_constraints = false;
          edge_effect = [
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