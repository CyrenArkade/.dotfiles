{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    ];
    
    settings = {
      bind = [
        "$mainMod, Tab, overview:toggle"
      ];
      plugin = {
        overview = {
          showNewWorkspace = false;
          exitOnSwitch = true;
          affectStrut = false;
          disableBlur = true;
          onBottom = true;
        };
      };
    };
  };
}