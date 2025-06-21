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
    };
  };

  home.file = {
    ".config/wofi/no-input.css" = {
      source = ./no-input.css;
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bindr = [
        "$mainMod, Super_L, exec, pkill wofi || fish -c \"wofi -i --width 250\""
      ];
    };
  };
}
