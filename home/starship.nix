{ lib, pkgs, config, ... }:

{
  programs.starship = {
    enable = true;
    # https://starship.rs/config/
    settings = {
      add_newline = false;
      format = lib.strings.concatStrings [
        "$directory"
        "$all"
        "$nix_shell"
        "$character"
      ];
      directory = {
        format = " [$path]($style)[$read_only]($read_only_style) ";
        truncate_to_repo = false;
        style = "bold lavender";
        fish_style_pwd_dir_length = 3;
      };
      git_branch = {
        only_attached = true;
        style = "teal";
      };
      git_commit = {
        format = "on [$tag \\($hash\\)]($style) ";
        tag_disabled = false;
        tag_symbol = "🏷 ";
        style = "teal";
      };
      git_state = {
        style = "sky";
      };
      git_status = {
        style = "sky";
      };
      hostname = {
        disabled = true;
      };
      nix_shell = {
        format = "$symbol$state";
        symbol = "❄️";
        pure_msg = "❄️";
        impure_msg = "";
      };
      username = {
        disabled = true;
      };
    };
  };
  programs.fish.shellInitLast = ''
    function starship_transient_prompt_func
      tput cuu1
      starship module character
    end

    function _prompt_gap --on-event fish_prompt
      functions -e _prompt_gap
      function _prompt_gap --on-event fish_prompt
        echo
      end
    end

    alias clear "command clear; commandline -f clear-screen"
  '';
  catppuccin.starship.enable = true;
}