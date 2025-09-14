{ lib, config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # if using autologin
    # exec-once = [
    #     "hyprlock --immediate --immediate-render --no-fade-in"
    # ];
    bind = [
      "$mainMod, L, exec, hyprlock"
    ];
    bindl = [
      ",switch:on:Lid Switch, exec, pidof hyprlock || hyprlock"
    ];
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      animations = {
        bezier = "linear, 1, 1, 0, 0";

        animation = [
          "fade, 1, 3, linear"
          "fadeIn, 1, 3, linear"
          "fadeOut, 1, 3, linear"
        ];
      };

      background = {
        monitor = "";
        path = toString ../../images/xilmo3.jpg;
        blur_passes = 2;
        color = "rgb(a093b2)";
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:5000] echo \"$(date +\"%R\")\""; # Time
          color = "rgb(cdd6f4)";
          font_size = 90;
          font_family = "Noto Sans Mono";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:60000] echo \"$(date +\"%A, %d %B %Y\")\""; # Date
          color = "rgb(cdd6f4)";
          font_size = 25;
          font_family = "Noto Sans Mono";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      image = {
        monitor = "";
        path = toString ../../images/icon.jpg;
        size = 100;
        border_color = "rgb(b4befe)";
        position = "0, 75";
        halign = "center";
        valign = "center";
      };

      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgb(b4befe)";
        inner_color = "rgb(313244)";
        font_color = "rgb(cdd6f4)";
        fade_on_empty = false;
        placeholder_text = "<span foreground=\"##cdd6f4\"><i>󰌾 Logged in as </i><span foreground=\"##b4befe\">$USER</span></span>";
        hide_input = false;
        check_color = "rgb(b4befe)";
        fail_color = "rgb(f38ba8)";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "rgb(f9e2af)";
        position = "0, -35";
        halign = "center";
        valign = "center";
      };
    };
  };
}