{ inputs, pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    neovim

    gnumake
    imagemagick

    lua-language-server
    ruff
  ];

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
}
