{ inputs, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    neovim

    # for plugins
    gnumake
    imagemagick
    luaPackages.tree-sitter-cli

    # language servers
    clang-tools
    kdePackages.qtdeclarative # qmlls
    lua-language-server
    nixd
    ruff
    ty
    typescript-go
    vscode-langservers-extracted
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
}
