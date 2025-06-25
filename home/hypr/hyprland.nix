{ inputs, pkgs, fetchurl, ... }:

let
  hshot = pkgs.writeShellScript "hshot" ''
    folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
    fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
    hyprshot -z -m region -o "$folderName" -f "$fileName"
  '';
in {
  imports = [
    ../waybar/waybar.nix
    ../wofi/wofi.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypredge.nix
    ./hyprspace.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    hyprshot
    hdrop
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {
      monitor = [
        ",preferred,auto,1.25"
      ];

      workspace = [
        "1, persistent:true"
        "2, persistent:true, default:true"
        "3, persistent:true"
        "special:mini, gapsout:128"
      ];
      
      xwayland.force_zero_scaling = true;
      
      exec-once = [
        # "hyprlock --immediate --immediate-render --no-fade-in" # if using autologin
        "systemctl --user start hyprpaper" # 
        "systemctl --user start hypridle"
        "wl-paste -p --watch wl-copy -pc"
        "[workspace 2] firefox"
        "[workspace 3 silent] vesktop"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 15;
        border_size = 2;
        "col.active_border" = "rgb(b4befe)";
        "col.inactive_border" = "rgba(11111baa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        active_opacity = 1;
        inactive_opacity = 1;
        dim_special = 0.4;

        blur = {
          enabled = true;
          size = 8;
          passes = 1;
          vibrancy = 0.2;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(b4befe77)";
          color_inactive = "rgba(11111baa)";
        };
      };

      animations = {
        enabled = true;
        workspace_wraparound = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 3, easeInOutCubic, slide"
          "workspacesIn, 1, 3, easeInOutCubic, slide"
          "workspacesOut, 1, 3, easeInOutCubic, slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      gestures = {
        workspace_swipe = true;
        workspace_swipe_create_new = false;
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
        middle_click_paste = true; # required or electron will emulate it.
      };

      input = {
        kb_layout = "us";
        kb_options = "caps:backspace";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.2;
        };
      };

      device = {
        name = "gxtp5100:00-27c6:01e0-touchpad";
        accel_profile = "custom 3 0 0.9 3.6 8.1";
      };

      cursor.no_warps = true;

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "workspace 3 silent, class:^vesktop$"
        "workspace 1 silent, class:^XIVLauncher.Core$"
        "workspace 1 silent, class:^ffxiv_dx11.exe$"
      ];

      layerrule = [];

      "$mainMod" = "SUPER";

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        "$mainMod SHIFT, left, resizeactive, 10 0"
        "$mainMod SHIFT, right, resizeactive, -10 0"
        "$mainMod SHIFT, up, resizeactive, 0 -10"
        "$mainMod SHIFT, down, resizeactive, 0 10"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -d intel_backlight s 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight s 5%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      bind = [
        "$mainMod, E, exec, kitty"
        "$mainMod, F, exec, firefox"
        "$mainMod, R, exec, kitty fish -C y"
        "$mainMod, Backspace, exec, hdrop -f -p t -g 0 -h 40 -w 67 kitty --class kitty_hdrop"
        ", mouse:276, exec, ${hshot}"
        "$mainMod, L, exec, hyprlock"

        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, A, workspace, e-1"
        "$mainMod, D, workspace, e+1"

        "$mainMod Shift, A, movetoworkspace, e-1"
        "$mainMod Shift, D, movetoworkspace, e+1"

        "$mainMod, W, togglespecialworkspace, mini"
        "$mainMod, S, movetoworkspacesilent, special:mini"
        "$mainMod, S, movetoworkspacesilent, +0"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mainMod, ${toString ws}, workspace, ${toString ws}"
              "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Fuchsia";
    size = 24;
    package = pkgs.fuchsia-cursor;
  };

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   name = "Fuchsia";
  #   size = 48;
  #   package = 
  #     pkgs.runCommand "moveUp" {} ''
  #       mkdir -p $out/share/icons
  #       ln -s ${pkgs.fetchzip {
  #         url = "https://github.com/ful1e5/fuchsia-cursor/releases/download/v2.0.1/Fuchsia.tar.xz";
  #         hash = "sha256-TuhU8UFo0hbVShqsWy9rTKnMV8/WHqsxmpqWg1d9f84=";
  #       }} $out/share/icons/Fuchsia
  #     ''
  #     # pkgs.stdenv.mkDerivation {
  #     #   name = "bibata-hyprcursor-modern-ice";
  #     #   src = fetchurl {
  #     #     url = "https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor/releases/download/1.0/hypr_Bibata-Modern-Ice.tar.gz";
  #     #     hash = "";
  #     #   };
  #     #   sourceRoot = ".";
  #     #   installPhase = ''
  #     #     tar -xzf *
  #     #     mkdir -p $out/share/icons/bibata-hyprcursor-modern-ice
  #     #     cp * $out/share/icons/bibata-hyprcursor-modern-ice
  #     #   '';
  #     # }
  #   ;
  # };
}