{ ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";
      confirm_os_window_close = 0;
      enable_audio_bell = 0;
      background_opacity = 0.95;
      cursor_trail = 50;
      font_size = 12;
    };
    keybindings = {
      "kitty_mod+f" = "kitten /home/cyren/.local/share/nvim/site/pack/core/opt/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py";
      "kitty_mod+h" = "";
      "kitty_mod+l" = "";
    };
  };
  catppuccin.kitty.enable = true;
}
