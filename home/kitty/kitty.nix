{ pkgs, ... }:

let
  # todo: ensure this has fzf and bat available (using wrapProgram?)
  fzf_history = pkgs.writeScript "fzf_history" (builtins.readFile ./fzf_history.sh);
in {
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = 0;
    };
    extraConfig = ''
      map ctrl+f launch --type=overlay --stdin-source=@screen_scrollback --stdin-add-formatting --copy-env ${fzf_history}
    '';
  };
  catppuccin.kitty.enable = true;
}