{ inputs, lib, pkgs, ... }:

let
  inherit (import ./lua_utils.nix { inherit lib; })
    on_startup;
in {
  wayland.windowManager.hyprland.settings = {
    on = on_startup ''hl.exec_cmd("systemctl --user start hypridle")'';
  };
  

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "qs -c ~/.dotfiles/shell ipc call lockscreen lockImmediate";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;
      };

      listener = [
        {
          timeout = 270;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s -d intel_backlight set 10";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r -d intel_backlight";
        } {
          timeout = 300;
          on-timeout = "qs -c ~/.dotfiles/shell ipc call lockscreen lock";
        } {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && ${pkgs.brightnessctl}/bin/brightnessctl -r -d intel_backlight";
        } {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
