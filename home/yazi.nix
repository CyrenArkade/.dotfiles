{ pkgs, ... }:

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
      
        { on = [ "g" "c" ]; run = "ignore";         desc = "Go ~/.config"; }
        { on = [ "g" "n" ]; run = "cd ~/.dotfiles"; desc = "Go ~/.dotfiles"; }
        { on = [ "g" "s" ]; run = "cd ~/Pictures/Screenshots"; desc = "Go ~/.dotfiles"; }

        { on = "<T>"; run = "close"; desc = "Close the current tab, or quit if it's last"; }

        { on = "e"; run = "visual_mode";         desc = "Enter visual mode (selection mode)"; }
	      { on = "E"; run = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }
      
        { on = "v"; run = "paste";         desc = "Paste yanked files"; }
	      { on = "V"; run = "paste --force"; desc = "Paste yanked files (overwrite if the destination exists)"; }
      ];
    };
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs.yaziPlugins.git;
      ouch = pkgs.yaziPlugins.ouch;
      starship = pkgs.yaziPlugins.starship;
    };
    initLua = ''
      require("full-border"):setup({
        type = ui.Border.PLAIN,
      })

      require("git"):setup()
      
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
