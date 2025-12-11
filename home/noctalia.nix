{ inputs, pkgs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "noctalia-shell"
  ];

  programs.noctalia-shell = {
    enable = true;
    colors = {
      mPrimary = "#b4befe";
      mOnPrimary = "#11111b";
      mSecondary = "#fab387";
      mOnSecondary = "#11111b";
      mTertiary = "#94e2d5";
      mOnTertiary = "#11111b";
      mError = "#f38ba8";
      mOnError = "#11111b";
      mSurface = "#181825";
      mOnSurface = "#cdd6f4";
      mSurfaceVariant = "#1e1e2e";
      mOnSurfaceVariant = "#a3b4eb";
      mOutline = "#313244";
      mShadow = "#11111b";
      mHover = "#94e2d5";
      mOnHover = "#11111b";
    };
    settings = {
      wallpaper.enabled = false;

      general = {
        avatarImage = ../images/icon.jpg;
      };

      bar = {
        position = "bottom";

        widgets = {
          left = [
            { id = "ActiveWindow"; }
            { id = "MediaMini"; }
          ];
          center = [
            { id = "Workspace"; }
          ];
          right = [
            { id = "Tray"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "Battery"; }
            { id = "Clock"; }
            { id = "ControlCenter"; }
          ];
        };
      };
    };
  };
}