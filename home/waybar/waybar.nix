{ pkgs, lib, ... }:

{
  # Creates ~/.config/waybar/catppuccin.css
  catppuccin.waybar = {
    enable = true;
    mode = "createLink";
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
  ];

  programs.waybar = {
    enable = true;
    style = ./style.css;

    settings = {
      main = {
        position = "bottom";
        height = 30;

        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          # "backlight"
          "battery"
          "custom/power"
          "clock"
        ];

        # https://github.com/Alexays/Waybar/wiki/Module:-Hyprland#window
        "hyprland/window" = {
          rewrite = {
            "(.*) — Mozilla Firefox" = "$1";
            "(.*) - Visual Studio Code" = "$1";
            "• Discord \\| ([^|]*) \\| ([^|]*)" = "$2 | $1";
          };
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          show-special = true;
          ignore-workspaces = [
            "special:hdrop"
          ];
        };
        tray = {
          # icon-size = 21;
          spacing = 6;
        };
        clock = {
          format = "{:%b %d  %R}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        network = {
          format-wifi = "";
          format-ethernet = "";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{essid} ({signalStrength}%) ";
          on-click-right = "hyprctl dispatch exec \"[float; move 70% 100%-w-40; size 350 400]\" plasmawindowed org.kde.plasma.networkmanagement";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = " {icon}";
          format-muted = "";
          format-icons = {
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
                ""
            ];
          };
          on-click = "pavucontrol";
        };
        "custom/power" = {
          format = "⏻";
          on-click = ./power.sh;
        };
      };
    };
  };
}