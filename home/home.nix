{ inputs, lib, pkgs, nixpkgs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin

    ./hypr/hyprland.nix
    ./kitty/kitty.nix
    ./theme/theme.nix
    ./neovim/neovim.nix
    ./vesktop/vesktop.nix

    ./cursor.nix
    ./fonts.nix

    ./fish.nix
    ./starship.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    android-tools
    brightnessctl
    bun
    distrobox
    fanficfare
    fd
    ffmpeg
    file
    ghostscript
    mediainfo
    ncdu
    nix-tree
    nvd
    ouch
    ov
    python313
    ripgrep
    tree
    vivid
    wl-clipboard
    
    calibre
    gimp3
    kdePackages.dolphin
    libreoffice-fresh
    prismlauncher
    qbittorrent
    xivlauncher
  ];

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.eza.enable = true;
  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  programs.vscode.enable = true;
  

  programs.bat.enable = true;
  catppuccin.bat.enable = true;

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      cudaSupport = true;
    };
    settings = {
      disks_filter = "exclude=/nix /home";
    };
  };
  catppuccin.btop.enable = true;

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };

  programs.fzf.enable = true;
  catppuccin.fzf.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "code --wait";
    };
  };

  programs.mpv.enable = true;
  catppuccin.mpv.enable = true;

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  xdg.portal.enable = true;

  services.blueman-applet.enable = true;


  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
  };

  nixpkgs.config.allowUnfree = true;

  news.display = "silent";

  home = {
    username = "cyren";
    homeDirectory = "/home/cyren";

    file = {};

    activation.report-changes = lib.hm.dag.entryAnywhere ''
      ${pkgs.nvd}/bin/nvd diff $oldGenPath $newGenPath
    '';

    sessionVariables = {
      LS_COLORS =  builtins.readFile (
        pkgs.runCommand "vivid-ls-colors" { } ''
          ${lib.getExe pkgs.vivid} generate catppuccin-mocha > $out
        ''
      );
      NIXOS_OZONE_WL = 1;
      NIXPKGS_ALLOW_UNFREE = 1;
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
      QT_SCALE_FACTOR_ROUNDING_POLICY = "Round";
      FZF_DEFAULT_OPTS = "--color bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4,header:#b4befe,hl:#b4befe,hl+:#b4befe,info:#b4befe,marker:#b4befe,pointer:#b4befe,prompt:#b4befe,spinner:#f5e0dc";
    };

    # DO NOT CHANGE
    stateVersion = "24.11";
  };
}
