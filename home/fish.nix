{ pkgs, fetchurl, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      fd = "fd -u";
      fzk = "ps -e | fzf | awk '{print $1}' | xargs kill";
      run = "hyprctl dispatch exec";
    };
    interactiveShellInit = ''
      function fish_title
        set -q argv[1] && set suffix ": $argv"; or set suffix ""
        echo (prompt_pwd)$suffix;
      end

      set fish_greeting
      set fish_prompt_pwd_dir_length 3
      set fish_prompt_pwd_full_dirs 3

      set fish_color_command cba6f7
      set fish_color_cwd a6e3a1
      set fish_color_param 89b4fa
      set fish_color_quote 94e2d5
      set fish_color_option f2cdcd
      set fish_color_cwd a6da95
      set fish_color_user b7bdf8
      set fish_color_host 7dc4e4
    '';
  };

  programs.nix-your-shell.enable = true;

  catppuccin.fish.enable = true;

  home = {
    shell.enableFishIntegration = true;

    sessionVariables = {
      SHELL = "fish";
    };
  };
}
