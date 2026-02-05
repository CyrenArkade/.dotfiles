{ lib, config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "quickshell -c ~/.dotfiles/shell" # i'll do it properly soom:tm:
    ];
    bind = [
      "$mainMod, L, exec, qs -c ~/.dotfiles/shell ipc call lockscreen lock"
    ];
    bindl = [
      ",switch:on:Lid Switch, exec, qs -c ~/.dotfiles/shell ipc call lockscreen lockImmediate"
    ];
  };
}