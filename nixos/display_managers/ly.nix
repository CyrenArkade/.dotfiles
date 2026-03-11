{ inputs, pkgs, ... }:

let
  ly-startup = pkgs.writeShellScript "ly-startup" ''
    printf '\e]P0181825\e]P71e1e2e\e]P811111b\e]Pfb4befe'
  '';
in {
  services.displayManager = {
    sessionPackages = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    ];
    ly = {
      enable = true;
      settings = {
        auth_fails = 3;
        hide_version_string = true;
        hide_key_hints = true;
        clear_password = true;

        # Map black->crust, white->base, brightblack->mantle, brightwhite->lavender
        # https://wiki.gentoo.org/wiki/Terminal_emulator/Colors#Linux_console
        start_cmd = "${ly-startup}";

        bg = "0x00555555";
        fg = "0x00ffffff";
        border_fg = "0x00ffffff";
        error_bg = "0x00555555";

        animation = "colormix";
        colormix_col1 = "0x00aaaaaa";
        colormix_col2 = "0x00555555";
        colormix_col3 = "0x00000000";
      };
    };
  };
}
