{ inputs, pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    neovim

    gnumake
    imagemagick

    lua-language-server
    ruff
    nixd
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
}
