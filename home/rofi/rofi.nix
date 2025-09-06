{ config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    extraConfig = {
      dpi = 144;
      show-icons = true;
      cycle = false;
      scroll-method = 1;
      drun-display-format = "{name}";
    };
    theme = {
      "*" = {
        background = mkLiteral "@mantle";
        lightfg = mkLiteral "@lavender";
        placeholder = mkLiteral "@overlay0";
        alternate-normal-background = mkLiteral "@background";
        alternate-active-background = mkLiteral "@background";
        alternate-urgent-background = mkLiteral "@background";
      };
      window = {
        width = mkLiteral "20em";
      };
      entry = {
        placeholder-color = mkLiteral "@placeholder";
      };
      num-rows = {
        text-color = mkLiteral "@placeholder";
      };
      num-filtered-rows = {
        text-color = mkLiteral "@placeholder";
      };
      textbox-num-sep = {
        text-color = mkLiteral "@placeholder";
      };
    };
  };
  catppuccin.rofi.enable = true;

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "stayfocused, class:^Rofi$"
      "norounding, class:^Rofi$"
    ];

    bindr = [
        # using pid is faster than pkill rofi || rofi
        "$mainMod, Super_L, exec, rofi -show drun -pid /tmp/wofi-pid || pkill rofi"
      ];
  };

  programs.yazi.settings = {
    opener = {
      rofi-open = [
        # -run-command '{cmd} "''"$@"'"'
        # concatenate '{cmd} "' + "$@" + '"'
        # to form {cmd} "$@" with $@ substituted in
        { run = "rofi -show drun -run-command '{cmd} \"'\"$@\"'\"'"; desc = "Open With"; }
      ];
    };
    open = {
      append_rules = [
        { name = "*"; use = "rofi-open"; }
        { name = "*/"; use = "rofi-open"; }
      ];
    };
  };
}