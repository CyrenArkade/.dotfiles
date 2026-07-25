{ lib, ... }:

let
  inherit (import ./hypr/lua_utils.nix { inherit lib; })
    bind exec on_startup;
in {
  wayland.windowManager.hyprland.settings = {
    # i'll do it properly soom:tm:
    on = on_startup ''hl.exec_cmd("quickshell -c ~/.dotfiles/shell")'';

    bind = map bind [
      ["SUPER + L" (exec "qs -c ~/.dotfiles/shell ipc call lockscreen lock")]
    ];
  };
}
