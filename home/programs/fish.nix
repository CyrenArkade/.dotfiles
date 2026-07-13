{ pkgs, fetchurl, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons"; # --hyperlink=auto once it hits nixpkgs
      fd = "fd -u --hyperlink=auto";
      nano = "micro";
      rg = "command rg --hyperlink-format=default";
      try = "nix-shell -p";
      
      afk = "systemd-inhibit sleep infinity";
      develop = ''function my_func -a dir; nix develop $dir --command bash -c "code $dir"; end; my_func'';
      fzk = "ps -e | fzf | awk '{print $1}' | xargs kill";
      mc = "run prismlauncher --launch";
      record = ''wf-recorder --codec h264_nvenc -g "$(slurp)" -f ~/Videos/output.mp4'';
      zws = "echo -n '​' | ${pkgs.wl-clipboard}/bin/wl-copy";
    };
    interactiveShellInit = ''
      function fish_title
        set -q argv[1] && set suffix ": $argv"; or set suffix ""
        echo (prompt_pwd)$suffix;
      end

      function run
        setsid $argv < /dev/null > /dev/null 2>&1 &
        disown
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
