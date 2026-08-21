{ inputs, pkgs, lib, ... }:

let
  inherit (import ./lua_utils.nix { inherit lib; })
    luaify lambda call bind exec bind_flags bind_exec with_flags on_startup;

  clipboard-history = pkgs.writeShellApplication {
    name = "clipboard-history";
    runtimeInputs = with pkgs; [ cliphist fzf wl-clipboard ];
    text = builtins.readFile ./clipboard-history.sh;
  };
in {
  imports = [
    ../programs/rofi.nix
    ../programs/swaync.nix
    ../screenshot/screenshot.nix
    # ../waybar/waybar.nix
    # ../wofi/wofi.nix
    ../quickshell.nix
    ./hypridle.nix
    # ./hyprlock.nix
    ./hyprpaper.nix
    ./hypredge.nix
  ];

  home.packages = with pkgs; [
    hyprpicker
    networkmanagerapplet
  ];

  services.cliphist.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    configType = "lua";
    settings = {
      config = {
        general = {
          border_size = 2;
          gaps_in = 3;
          gaps_out = 15;
          col.active_border = "#b4befe";
          col.inactive_border = "#11111baa";
          layout = "dwindle";
        };

        decoration = {
          rounding = 0;
          rounding_power = 2;

          active_opacity = 1;
          inactive_opacity = 1;
          dim_special = 0.4;

          blur = {
            enabled = true;
            size = 5;
            passes = 2;
            vibrancy = 0.2;
          };

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "#b4befe77";
            color_inactive = "#11111baa";
          };
        };

        animations = {
          enabled = true;
          workspace_wraparound = true;
        };

        input = {
          kb_layout = "us";
          numlock_by_default = true;
          focus_on_close = 1;
          sensitivity = 0;
          accel_profile = "flat";

          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.2;
            clickfinger_behavior = true;
          };
        };

        gestures = {
          workspace_swipe_create_new = false;
        };

        dwindle = {
          preserve_split = true;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        render = {
          cm_enabled = false;
        };

        cursor = {
          no_warps = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          background_color = "#1e1e2e";

          middle_click_paste = true; # required or electron will emulate it.
          enable_anr_dialog = true;
          enable_swallow = true;
          swallow_regex = "^(kitty)$";
          session_lock_xray = true;
        };
      };

      monitor = {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1.25;
      };

      device = {
        name = "gxtp5100:00-27c6:01e0-touchpad";
        accel_profile = "custom 3 0 0.9 3.6 8.1";
      };

      gesture = [
        { fingers = 3; direction = "horizontal"; action = "workspace"; }
        { fingers = 3; direction = "swipe"; mods = "SUPER"; action = "resize"; }
      ];

      curve = [
        (call ["easeOutQuint"   { type = "bezier"; points = [[0.23 1]    [0.32 1]]; }])
        (call ["easeInOutCubic" { type = "bezier"; points = [[0.65 0.05] [0.36 1]]; }])
        (call ["linear"         { type = "bezier"; points = [[0    0]    [1    1]]; }])
        (call ["almostLinear"   { type = "bezier"; points = [[0.5  0.5]  [0.75 1]]; }])
        (call ["quick"          { type = "bezier"; points = [[0.15 0]    [0.1  1]]; }])
        (call ["easy"           { type = "spring"; mass = 1; stiffness = 500; dampening = 32; }])
      ];

      animation = [
        { leaf = "global";           enabled = true; speed = 10;   bezier = "default"; }
        { leaf = "border";           enabled = true; speed = 5.39; bezier = "easeOutQuint"; }
        { leaf = "windows";          enabled = true; speed = 1;    spring = "easy"; }
        { leaf = "windowsIn";        enabled = true; speed = 1;    spring = "easy";           style = "popin 40%"; }
        { leaf = "windowsOut";       enabled = true; speed = 1;    spring = "easy";           style = "popin 60%"; }
        { leaf = "windowsMove";      enabled = true; speed = 1;    spring = "easy";           style = "popin 40%"; }
        { leaf = "fadeIn";           enabled = true; speed = 1.73; bezier = "almostLinear"; }
        { leaf = "fadeOut";          enabled = true; speed = 1.46; bezier = "almostLinear"; }
        { leaf = "fade";             enabled = true; speed = 3.03; bezier = "quick"; }
        { leaf = "layers";           enabled = true; speed = 3.81; bezier = "easeOutQuint"; }
        { leaf = "layersIn";         enabled = true; speed = 4;    bezier = "easeOutQuint";   style = "fade"; }
        { leaf = "layersOut";        enabled = true; speed = 1.5;  bezier = "linear";         style = "fade"; }
        { leaf = "fadeLayersIn";     enabled = true; speed = 1.79; bezier = "almostLinear"; }
        { leaf = "fadeLayersOut";    enabled = true; speed = 1.39; bezier = "almostLinear"; }
        { leaf = "workspaces";       enabled = true; speed = 2;    bezier = "easeOutQuint"; style = "slide"; }
        { leaf = "specialWorkspace"; enabled = true; speed = 3;    bezier = "easeInOutCubic"; style = "slidevert"; }
        { leaf = "zoomFactor";       enabled = true; speed = 7;    bezier = "quick"; }
      ];

      window_rule = [
        { match.class = ".*"; suppress_event = "maximize"; }
        { match = { class = "^$"; title = "^$"; xwayland = true; float = true; fullscreen = false; pin = false; }; no_focus = true; }

        { match.class = "vesktop"; workspace = "3 silent"; }
        { match.class = "XIVLauncher.Core"; workspace = "1 silent"; }
        { match.title = "FINAL FANTASY XIV"; workspace = "1 silent"; }
        { match.title = ".*Minecraft.*"; workspace = "1 silent"; }
        { match.title = "waywall"; workspace = "1 silent"; }

        { match.class = "Matplotlib"; float = true; }
        { match.class = "com.interversehq.qView"; suppress_event = "fullscreen maximize"; }
        { match.title = "Please wait.*Prism Launcher.*"; float = true; no_initial_focus = true; }
        { match.title = "FINAL FANTASY XIV"; no_anim = true; }
      ];

      layer_rule = [
        { match.namespace = "quickshell"; no_anim = true; }
      ];

      workspace_rule = [
        { workspace = "1"; persistent = true; }
        { workspace = "2"; persistent = true; default = true; }
        { workspace = "3"; persistent = true; }
        { workspace = "special:mini"; gaps_out = 128; }
      ];

      on = on_startup ''
        -- hl.exec_cmd("${pkgs.wl-clipboard}/bin/wl-paste -p --watch ${pkgs.wl-clipboard}/bin/wl-copy -pc")
        hl.exec_cmd("firefox", { workspace = "2"; })
        hl.exec_cmd("vesktop", { workspace = "3 silent"; })
        hl.exec_cmd("nm-applet")
        hl.exec_cmd("a2ln")
      '';

      bind = map bind (builtins.concatLists [
        [
          ["SUPER + M" "hl.dsp.exit()"]
          ["SUPER + Q" "hl.dsp.window.close()"]
          ["SUPER + C" "hl.dsp.window.float()"]
          ["SUPER + F" "hl.dsp.window.fullscreen()"]
          ["SUPER + P" "hl.dsp.window.pseudo()"]
          ["SUPER + O" "hl.dsp.window.pin()"]
          
          ["SUPER + X" ''hl.dsp.submap("launch")'']

          ["SUPER + E" (exec "kitty")]
          ["SUPER + R" (exec "kitty fish -C y")]
          ["SUPER + V" ''hl.dsp.exec_cmd("kitty ${clipboard-history}/bin/clipboard-history", { float = true, size = {800, 400}, center = true })'']

          ["SUPER + K" ''hl.dsp.focus({ direction = "u" })'']
          ["SUPER + J" ''hl.dsp.focus({ direction = "d" })'']
          ["SUPER + H" ''hl.dsp.focus({ direction = "l" })'']
          ["SUPER + L" ''hl.dsp.focus({ direction = "r" })'']

          ["SUPER + SHIFT + K" ''hl.dsp.window.swap({ direction = "u" })'']
          ["SUPER + SHIFT + J" ''hl.dsp.window.swap({ direction = "d" })'']
          ["SUPER + SHIFT + H" ''hl.dsp.window.swap({ direction = "l" })'']
          ["SUPER + SHIFT + L" ''hl.dsp.window.swap({ direction = "r" })'']

          ["SUPER + A" ''hl.dsp.focus({ workspace = "e-1" })'']
          ["SUPER + D" ''hl.dsp.focus({ workspace = "e+1" })'']
          ["SUPER + SHIFT + A" ''hl.dsp.window.move({ workspace = "e-1" })'']
          ["SUPER + SHIFT + D" ''hl.dsp.window.move({ workspace = "e+1" })'']

          ["SUPER + W" ''hl.dsp.workspace.toggle_special("mini")'']
          ["SUPER + S" (lambda ''
            local mini_ws = hl.get_active_special_workspace()
            if mini_ws == nil then
              hl.dispatch(hl.dsp.window.move({ workspace = "special:mini", follow = false }))
            else
              local is_last = #mini_ws:get_windows() == 1
              hl.dispatch(hl.dsp.window.move({ workspace = "+0", follow = is_last }))
            end
          '')]

          ["SUPER + escape" (lambda ''

            local monitor = hl.get_active_monitor()
            local x = monitor.x + 1/6 * monitor.width / monitor.scale
            local y = monitor.y
            local width = 2/3 * monitor.width / monitor.scale
            local height = 0.4 * monitor.height / monitor.scale

            local quake = hl.get_windows({ tag = "quake*" })[1]

            if quake == nil then
              hl.exec_cmd("kitty --class quake -o background_opacity=1", { tag = "quake", floating = true, move = {x, y}, size = {width, height} })
            elseif quake.workspace == hl.get_active_workspace() then
              hl.dispatch(hl.dsp.window.move({ window = quake, workspace = "special:quake", follow = false }))
              hl.dispatch(hl.dsp.window.move({ window = quake, x = x, y = -height/8 }))
            else
              hl.dispatch(hl.dsp.window.float({ window = quake, action = "on" }))
              hl.dispatch(hl.dsp.window.move({ window = quake, workspace = "+0", follow = false }))
              hl.dispatch(hl.dsp.window.resize({ window = quake, x = width, y = height }))
              hl.dispatch(hl.dsp.window.move({ window = quake, x = x, y = y }))
              hl.dispatch(hl.dsp.focus({ window = quake }))
            end
          '')]
        ]

        (with_flags { repeating = true; } [
          ["SUPER + SHIFT + left"  "hl.dsp.window.resize({ x = -10, y = 0   })"]
          ["SUPER + SHIFT + right" "hl.dsp.window.resize({ x = 10,  y = 0   })"]
          ["SUPER + SHIFT + up"    "hl.dsp.window.resize({ x = 0,   y = -10 })"]
          ["SUPER + SHIFT + down"  "hl.dsp.window.resize({ x = 0,   y = 10  })"]
        ])

        (with_flags { locked = true; } [
          ["XF86AudioNext"  (exec "playerctl next")]
          ["XF86AudioPause" (exec "playerctl play-pause")]
          ["XF86AudioPlay"  (exec "playerctl play-pause")]
          ["XF86AudioPrev"  (exec "playerctl previous")]
        ])

        (with_flags { repeating = true; locked = true; } [
          ["XF86AudioRaiseVolume"  (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")]
          ["XF86AudioLowerVolume"  (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")]
          ["XF86AudioMute"         (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")]
          ["XF86AudioMicMute"      (exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")]
          ["XF86MonBrightnessUp"   (exec "${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight s 5%+")]
          ["XF86MonBrightnessDown" (exec "${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight s 5%-")]
        ])

        (with_flags { mouse = true; } [
          ["SUPER + mouse:272" "hl.dsp.window.drag()"]
          ["SUPER + mouse:273" "hl.dsp.window.resize()"]
        ])

        (with_flags { mouse = true; non_consuming = true; } [
          ["mouse:274" (exec "wl-copy -pc")]
        ])

        (with_flags { non_consuming = true; } [
         ["f6" ''hl.dsp.global("com.obsproject.Studio:OBSBasic.StartRecording")'']
         ["f7" ''hl.dsp.global("com.obsproject.Studio:OBSBasic.StopRecording")'']
        ])

        (builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            ["SUPER + ${toString ws}" ''hl.dsp.focus({ workspace = "${toString ws}" })'']
            ["SUPER + SHIFT + ${toString ws}" ''hl.dsp.window.move({ workspace = "${toString ws}" })'']
          ]
        ) 9))
      ]);
    };

    submaps = {
      launch = {
        onDispatch = "reset";
        settings.bind = map bind [
          ["F" (exec "firefox")]
          ["X" (exec "XIVLauncher.Core")]
          ["C" (exec "kitty nvim")]
          ["G" (exec "gimp")]
          ["V" (exec "vesktop")]
          ["P" (exec "prismlauncher")]
          ["O" (exec "obs")]
          ["S" (exec "steam")]
          ["E" (exec "scalc")]
          ["catchall" ''hl.dsp.submap("reset")'']
        ];
      };
    };
  };
}
