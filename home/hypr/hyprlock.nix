{ lib, config, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
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

      # BACKGROUND
      background = {
        monitor = "";
        path = toString ../../images/xilmo2.jpg;
        blur_passes = 2;
        color = "rgb(a093b2)";
      };

      label = [
        # TIME
        {
          monitor = "";
          text = "cmd[update:30000] echo \"$(date +\"%R\")\"";
          color = "rgb(cdd6f4)";
          font_size = 90;
          font_family = "Noto Sans Mono";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        # DATE 
        {
          monitor = "";
          text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
          color = "rgb(cdd6f4)";
          font_size = 25;
          font_family = "Noto Sans Mono";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      # USER AVATAR

      image = {
        monitor = "";
        path = "~/.face";
        size = 100;
        border_color = "rgb(b4befe)";
        position = "0, 75";
        halign = "center";
        valign = "center";
      };

      # INPUT FIELD
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
        fail_color = "$red";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "rgb(f9e2af)";
        position = "0, -35";
        halign = "center";
        valign = "center";
      };
    };
  };
}