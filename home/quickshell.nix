{ lib, config, ... }:

let
  inherit (import ./hypr/lua_utils.nix { inherit lib; })
    call bind_exec with_flags on_startup;
in {
  wayland.windowManager.hyprland.settings = {
    # i'll do it properly soom:tm:
    on = on_startup ''hl.exec_cmd("quickshell -c ~/.dotfiles/shell")'';

    bind = map call (builtins.concatLists [
      (with_flags {} [
        (bind_exec "SUPER + L" "qs -c ~/.dotfiles/shell ipc call lockscreen lock")
      ])
    ]);
  };
}
