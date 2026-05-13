{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    xdg-desktop-portal-termfilechooser
  ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    settings = {
      mgr = {
        sort_dir_first = false;
        show_hidden = true;
      };
      opener = {
        extract     = [ { desc = "Extract"; run = "ouch d -y %s"; } ];
        open        = [ { desc = "Open";    run = "xdg-open %s1"; } ];
        open-orphan = [ { desc = "Open";    run = "xdg-open %s1"; orphan = true; } ];
        reveal      = [];
        open-with = [
          # -run-command "sh -c '{cmd} \"\$@\"' _ %s"
          # inserts %s as the args after the zeroth (aka as $@) into
          # {cmd} "$@"
          { run = ''rofi -show drun -x11 -run-command "sh -c '{cmd} \"\$@\"' _ %s"''; desc = "Open With"; orphan = true; }
        ];
        copy = [
          { desc = "Copy"; run = "wl-copy < %s1"; }
          { desc = "Copy Path"; run = "echo -n %s1 | wl-copy"; }
        ];

        gimp    = [ { desc = "GIMP";    run = "gimp %s1"; orphan = true; } ];
        micro   = [ { desc = "Micro";   run = "micro %s1"; block = true; } ];
        vscode  = [ { desc = "VS Code"; run = "code %s1"; } ];
      };
      open = {
        rules = [
          { url = "*/";                use = [ "vscode" "open-with" ]; }
          { mime = "text/*";           use = [ "micro" "vscode" "copy" "open-with" ]; }
          { mime = "image/*";          use = [ "open-orphan" "gimp" "copy" "open-with" ]; }
          { mime = "{audio,video}/*";  use = [ "open-orphan" "copy" "open-with" ]; }
          { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}"; use = [ "extract" "copy" "open-with" ]; }
          { mime = "application/json"; use = [ "micro" "vscode" "copy" "open-with" ]; }
          { mime = "*/javascript";     use = [ "micro" "vscode" "copy" "open-with" ]; }
          { url = "*";                 use = [ "open" "copy" "open-with" ]; }
        ];
      };
      plugin = {
        prepend_fetchers = [
          { id = "git"; name = "*";  run = "git"; }
          { id = "git"; name = "*/"; run = "git"; }
        ];
        prepend_previewers = [
          { mime = "application/*zip";            run = "ouch"; }
          { mime = "application/x-tar";           run = "ouch"; }
          { mime = "application/x-bzip2";         run = "ouch"; }
          { mime = "application/x-7z-compressed"; run = "ouch"; }
          { mime = "application/x-rar";           run = "ouch"; }
          { mime = "application/x-xz";            run = "ouch"; }
          { mime = "application/xz";              run = "ouch"; }
        ];
      };
    };
    # https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap-default.toml
    keymap = {
      mgr.prepend_keymap = [
        { on = "<Enter>";   run = "plugin smart-enter"; desc = "Enter directory or open file"; }
        { on = "<C-Enter>"; run = "open";               desc = "Enter directory or open file"; }

        { on = "c"; run = "yank";   desc = "Yank selected files (copy)"; }
        { on = "C"; run = "unyank"; desc = "Yank selected files (copy)"; }

        { on = [ "<A-c>" "c" ]; run = "copy path";             desc = "Copy the file path"; }
        { on = [ "<A-c>" "d" ]; run = "copy dirname";          desc = "Copy the directory path"; }
        { on = [ "<A-c>" "f" ]; run = "copy filename";         desc = "Copy the filename"; }
        { on = [ "<A-c>" "n" ]; run = "copy name_without_ext"; desc = "Copy the filename without extension"; }
      
        { on = [ "g" "c" ]; run = "cd ~/.dotfiles";            desc = "Go ~/.dotfiles"; }
        { on = [ "g" "d" ]; run = "cd ~/dev";                  desc = "Go ~/dev"; }
        { on = [ "g" "D" ]; run = "cd ~/Downloads";            desc = "Go ~/Downloads"; }
        { on = [ "g" "p" ]; run = "cd ~/Pictures";             desc = "Go ~/Pictures"; }
        { on = [ "g" "s" ]; run = "cd ~/Pictures/Screenshots"; desc = "Go ~/.../Screenshots"; }
        { on = [ "g" "v" ]; run = "cd ~/Videos";               desc = "Go ~/Videos"; }

        { on = "<T>"; run = "close"; desc = "Close the current tab, or quit if it's last"; }

        { on = "e"; run = "visual_mode";         desc = "Enter visual mode (selection mode)"; }
	      { on = "E"; run = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }
      
        { on = "v"; run = "paste";         desc = "Paste yanked files"; }
	      { on = "V"; run = "paste --force"; desc = "Paste yanked files (overwrite if the destination exists)"; }

        { on = "."; run = [ "hidden toggle" "plugin pref-by-location -- save" ]; desc = "Toggle the visibility of hidden files"; }

        # pref-by-location linemode
        { on = [ "m" "s" ]; run = [ "linemode size" "plugin pref-by-location -- save" ];        desc = "Linemode: size"; }
        { on = [ "m" "p" ]; run = [ "linemode permissions" "plugin pref-by-location -- save" ]; desc = "Linemode: permissions"; }
        { on = [ "m" "b" ]; run = [ "linemode btime" "plugin pref-by-location -- save" ];       desc = "Linemode: btime"; }
        { on = [ "m" "m" ]; run = [ "linemode mtime" "plugin pref-by-location -- save" ];       desc = "Linemode: mtime"; }
        { on = [ "m" "o" ]; run = [ "linemode owner" "plugin pref-by-location -- save" ];       desc = "Linemode: owner"; }
        { on = [ "m" "n" ]; run = [ "linemode none" "plugin pref-by-location -- save" ];        desc = "Linemode: none"; }

        # pref-by-location linemode
        { on = [ "," "t" ]; run = "plugin pref-by-location -- toggle";                                              desc = "Toggle pref auto-save"; }
        # { on = [ "," "d" ]; run = "plugin pref-by-location -- disable";                                             desc = "Disable auto-save preferences"; }
        { on = [ "," "R" ]; run = [ "plugin pref-by-location -- reset" ];                                           desc = "Reset saved pref"; }
        { on = [ "," "m" ]; run = [ "sort mtime --reverse=no" "linemode mtime" "plugin pref-by-location -- save" ]; desc = "󰌼 Modified"; }
        { on = [ "," "M" ]; run = [ "sort mtime --reverse" "linemode mtime" "plugin pref-by-location -- save" ];    desc = "󰒿 Modified"; }
        { on = [ "," "b" ]; run = [ "sort btime --reverse=no" "linemode btime" "plugin pref-by-location -- save" ]; desc = "󰌼 Birth"; }
        { on = [ "," "B" ]; run = [ "sort btime --reverse" "linemode btime" "plugin pref-by-location -- save" ];    desc = "󰒿 Birth"; }
        { on = [ "," "e" ]; run = [ "sort extension --reverse=no" "plugin pref-by-location -- save" ];              desc = "󰌼 Extension"; }
        { on = [ "," "E" ]; run = [ "sort extension --reverse" "plugin pref-by-location -- save" ];                 desc = "󰒿 Extension"; }
        { on = [ "," "a" ]; run = [ "sort alphabetical --reverse=no" "plugin pref-by-location -- save" ];           desc = "󰌼 Alphabetically"; }
        { on = [ "," "A" ]; run = [ "sort alphabetical --reverse" "plugin pref-by-location -- save" ];              desc = "󰒿 Alphabetically"; }
        { on = [ "," "n" ]; run = [ "sort natural --reverse=no" "plugin pref-by-location -- save" ];                desc = "󰌼 Naturally"; }
        { on = [ "," "N" ]; run = [ "sort natural --reverse" "plugin pref-by-location -- save" ];                   desc = "󰒿 Naturally"; }
        { on = [ "," "s" ]; run = [ "sort size --reverse=no" "linemode size" "plugin pref-by-location -- save" ];   desc = "󰌼 Size"; }
        { on = [ "," "S" ]; run = [ "sort size --reverse" "linemode size" "plugin pref-by-location -- save" ];      desc = "󰒿 Size"; }
        { on = [ "," "r" ]; run = [ "sort random --reverse=no" "plugin pref-by-location -- save" ];                 desc = "Sort randomly"; }
      ];
    };
    plugins = with pkgs; {
      full-border = yaziPlugins.full-border;
      git = yaziPlugins.git;
      ouch = yaziPlugins.ouch;
      smart-enter = yaziPlugins.smart-enter;
      starship = yaziPlugins.starship;
      
      pref-by-location = local.pref-by-location;
    };
    initLua = ''
      require("full-border"):setup({
        type = ui.Border.PLAIN,
      })

      require("git"):setup()

      -- requires keymaps to work
      require("pref-by-location"):setup({})
      
      -- Add padding before starship
      Header:children_add(function(self)
        return " "
      end, 999, Header.LEFT)
      require("starship"):setup()

      require("smart-enter"):setup({})
    '';
  };

  xdg.configFile = let
    cfg = config.catppuccin.yazi;
  in {
    # need to augment this due to https://github.com/catppuccin/yazi/issues/35
    "yazi/theme.toml".text = (builtins.readFile "${config.catppuccin.sources.yazi}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.toml") + ''
      conds = [
        { if = "dir", text = "", fg = "#b4befe" }
      ]

      dirs  = [
        { name = ".config", text = "", fg = "#b4befe" },
        { name = ".git", text = "", fg = "#b4befe" },
        { name = ".github", text = "", fg = "#b4befe" },
        { name = ".npm", text = "", fg = "#b4befe" },
        { name = "Desktop", text = "", fg = "#b4befe" },
        { name = "Development", text = "", fg = "#b4befe" },
        { name = "Documents", text = "", fg = "#b4befe" },
        { name = "Downloads", text = "", fg = "#b4befe" },
        { name = "Library", text = "", fg = "#b4befe" },
        { name = "Movies", text = "", fg = "#b4befe" },
        { name = "Music", text = "", fg = "#b4befe" },
        { name = "Pictures", text = "", fg = "#b4befe" },
        { name = "Public", text = "", fg = "#b4befe" },
        { name = "Videos", text = "", fg = "#b4befe" },
      ]
    '';
    "yazi/Catppuccin-${cfg.flavor}.tmTheme".source = "${config.catppuccin.sources.bat}/Catppuccin ${lib.toSentenceCase cfg.flavor}.tmTheme";

    "xdg-desktop-portal-termfilechooser/config" = {
      text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$HOME
        open_mode=last
        save_mode=last
      '';
      recursive = true;
    };
  };
}
