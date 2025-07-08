{ pkgs, ... }:

let
  pref-by-location = pkgs.stdenvNoCC.mkDerivation {
    name = "pref-by-location";
    src = pkgs.fetchFromGitHub {
      owner = "boydaihungst";
      repo = "pref-by-location.yazi";
      rev = "68f006da24870761a3926eed13c877ce2b4a4559";
      hash = "sha256-mmEQBigbHkxmRBQDEt4WSqlZGC+200k+4/4tjUk+484=";
    };
    installPhase = "cp -r . $out/";
  };
in {
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
        vscode = [
          { run = "code \"$0\""; desc = "VS Code"; }
        ];
      };
      open = {
        append_rules = [
          { name = "*"; use = "vscode"; }
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
        { on = "c"; run = "yank";   desc = "Yank selected files (copy)"; }
        { on = "C"; run = "unyank"; desc = "Yank selected files (copy)"; }

        { on = [ "<A-c>" "c" ]; run = "copy path";             desc = "Copy the file path"; }
        { on = [ "<A-c>" "d" ]; run = "copy dirname";          desc = "Copy the directory path"; }
        { on = [ "<A-c>" "f" ]; run = "copy filename";         desc = "Copy the filename"; }
        { on = [ "<A-c>" "n" ]; run = "copy name_without_ext"; desc = "Copy the filename without extension"; }
      
        { on = [ "g" "c" ]; run = "cd ~/.dotfiles"; desc = "Go ~/.dotfiles"; }
        { on = [ "g" "d" ]; run = "cd ~/dev"; desc = "Go ~/dev"; }
        { on = [ "g" "s" ]; run = "cd ~/Pictures/Screenshots"; desc = "Go Screenshots"; }

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
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs.yaziPlugins.git;
      ouch = pkgs.yaziPlugins.ouch;
      pref-by-location = pref-by-location;
      starship = pkgs.yaziPlugins.starship;
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
    '';
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      default_dir=$HOME
      open_mode=last
      save_mode=last
    '';
    recursive = true;
  };

  catppuccin.yazi.enable = true;
}
