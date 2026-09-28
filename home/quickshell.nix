{ lib, pkgs, ... }:

let
  inherit (import ./hypr/lua_utils.nix { inherit lib; })
    bind exec on_startup;
in {
  home.packages = with pkgs; [ strawb ];

  wayland.windowManager.hyprland.settings = {
    on = on_startup ''hl.exec_cmd("${pkgs.strawb}/bin/strawb")'';

    bind = map bind [
      ["SUPER + Z" (exec "${pkgs.strawb}/bin/strawb lock")]
    ];
  };
}
