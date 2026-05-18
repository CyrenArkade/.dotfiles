{ config, lib, ... }:

let
  inherit (import ../hypr/lua_utils.nix { inherit lib; })
    call bind_exec with_flags;
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
    window_rule = [
      { match.class = "Rofi"; stay_focused = true; rounding = 0; }
    ];

    bind = map call (builtins.concatLists [
      (with_flags { release = true; } [
        (bind_exec "SUPER + Super_L" "rofi -show drun -x11 || pkill rofi")
      ])
    ]);
  };
}