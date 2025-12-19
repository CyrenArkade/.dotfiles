{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hypredge.packages.${pkgs.stdenv.hostPlatform.system}.hypredge
    ];
    
    settings = {
      plugin = {
        hypredge = {
          edge_effect = [
            "left, workspace, e-1"
            "left, hypredge:movecursortoedge, right"
            "right, workspace, e+1"
            "right, hypredge:movecursortoedge, left"
          ];
        };
      };
      windowrule = [
        "match:title FINAL FANTASY XIV, hypredge:ignore_constraints on"
      ];
    };
  };
}