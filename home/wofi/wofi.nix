{ ... }:

{
  programs.wofi = {
    enable = true;
    style = ./style.css;
    settings = {
      show = "drun";
      allow_images = true;
      image_size = 20;
      hide_scroll = true;
      prompt = ";-;";
      key_expand = "Right";
      insensitive = true;
    };
  };

  # There is an option for this in git, but css can emulate it.
  xdg.configFile."wofi/no-input.css".text = ''
    @import "${./style.css}";

    #input {
      opacity: 0;
      margin-top: -999px;
    }
  '';

  wayland.windowManager.hyprland = {
    settings = {
      bindr = [
        "$mainMod, Super_L, exec, pkill wofi || wofi --width 250"
      ];
    };
  };
}
