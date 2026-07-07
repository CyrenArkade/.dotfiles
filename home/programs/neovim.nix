{ inputs, pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
}
