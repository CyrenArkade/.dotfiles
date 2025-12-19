{ inputs, lib, pkgs, nixpkgs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin

    ./hypr/hyprland.nix
    ./kitty/kitty.nix
    ./theme/theme.nix
    ./vesktop/vesktop.nix

    ./cursor.nix
    ./fonts.nix

    ./fish.nix
    ./micro.nix
    ./starship.nix
    ./yazi.nix
  ];

  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];

  home.packages = with pkgs; [
    android-tools
    bun
    distrobox
    fanficfare
    fd
    ffmpeg
    file
    gcc
    ghostscript
    mediainfo
    ncdu
    nix-tree
    nvd
    ouch
    ov
    python313
    ripgrep
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
      ];
    }))
    tree
    wl-clipboard
    inputs.zmx.packages.${pkgs.stdenv.hostPlatform.system}.zmx
    
    calibre
    cosmic-files
    gimp3
    libreoffice-fresh
    prismlauncher
    qbittorrent
    zoom-us
  ];

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.eza.enable = true;
  programs.firefox.enable = true;
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

  programs.fzf = {
    enable = true;
    colors = {
      selected-bg = "#45475A";
      border = "#6C7086";
      label = "#CDD6F4";
    };
  };
  catppuccin.fzf.enable = true;

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core.editor = "code --wait";
    };
  };

  programs.mpv.enable = true;
  catppuccin.mpv.enable = true;

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
  };

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
    };

    # DO NOT CHANGE
    stateVersion = "24.11";
  };
}
