{ pkgs, ... }:

let
  fzf-history = pkgs.writeShellApplication {
    name = "fzf-history";
    runtimeInputs = with pkgs; [ fzf bat ];
    text = builtins.readFile ./fzf-history.sh;
  };
in {
  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "yes";
      confirm_os_window_close = 0;
      enable_audio_bell = 0;
      background_opacity = 0.95;
      cursor_trail = 50;
    };
    keybindings = {
      "ctrl+f" = "launch --type=overlay --stdin-source=@screen_scrollback --stdin-add-formatting --copy-env ${fzf-history}/bin/fzf-history";
      "kitty_mod+h" = "";
      "kitty_mod+l" = "";
    };
  };
  catppuccin.kitty.enable = true;
}
