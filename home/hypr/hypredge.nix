{ inputs, pkgs, lib, ... }:

let
  inherit (import ./lua_utils.nix { inherit lib; })
    luaify lambda call;
in {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hypredge.packages.${pkgs.stdenv.hostPlatform.system}.hypredge
    ];
    
    extraConfig = ''
      if hl.plugin.hypredge ~= nil then
        hl.plugin.hypredge.edge_effect("left", function()
          hl.dispatch(hl.dsp.focus({ workspace = "e-1" }))
          hl.plugin.hypredge.move_cursor_to_edge("right")
        end)

        hl.plugin.hypredge.edge_effect("right", function()
          hl.dispatch(hl.dsp.focus({ workspace = "e+1" }))
          hl.plugin.hypredge.move_cursor_to_edge("left")
        end)

        hl.window_rule({
          match = { title = "FINAL FANTASY XIV|Pathfinder Wrath Of The Righteous" },
          hypredge_ignore_constraints = "on",
        })
      end
    '';
  };
}
