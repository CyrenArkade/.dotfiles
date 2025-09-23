{ inputs, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user start hypridle"
    ];
  };
  

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;
      };

      listener = [
        {
          timeout = 270;
          on-timeout = "brightnessctl -s -d intel_backlight set 10";
          on-resume = "brightnessctl -r -d intel_backlight";
        } {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        } {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r -d intel_backlight";
        } {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}