{ inputs, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    neovim

    gnumake
    imagemagick

    kdePackages.qtdeclarative # qmlls
    lua-language-server
    nixd
    ruff
    vscode-langservers-extracted
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
}
