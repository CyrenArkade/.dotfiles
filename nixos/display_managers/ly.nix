{ inputs, pkgs, ... }:

{
  services.displayManager = {
    sessionPackages = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    ];
    ly = {
      enable = true;
      settings = {
        animation = "colormix";
        auth_fails = 3;
        hide_version_string = true;
        hide_key_hints = true;
        bg = "0x001e1e2e";
        fg = "0x00b4befe";
        border_fg = "0x00cdd6f4";
        colormix_col1 = "0x0000FFFF";
        colormix_col2 = "0x00FF00FF";
        colormix_col3 = "0x00FFFFFF";
      };
    };
  };
}