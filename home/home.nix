{ inputs, lib, pkgs, nixpkgs, config, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin

    ./hypr/hyprland.nix
    ./kitty/kitty.nix
    ./mpd/mpd.nix
    ./theme/theme.nix
    ./vesktop/vesktop.nix

    ./cursor.nix
    ./fonts.nix

    ./programs/fish.nix
    ./programs/micro.nix
    ./programs/neovim.nix
    ./programs/starship.nix
    ./programs/yazi.nix
  ];

  nixpkgs.overlays = [
    inputs.self.overlays.local
    inputs.rust-overlay.overlays.default
  ];

  home.packages = with pkgs; [
    android-tools
    bun
    distrobox
    entr
    eyed3
    fanficfare
    fd
    ffmpeg
    file
    gcc
    gdu
    ghostscript
    grim
    img2pdf
    kdePackages.qtdeclarative # for qmlls
    gnumake
    mediainfo
    nix-tree
    nvd
    ouch
    # (ouch.override {
    #   enableUnfree = true;
    # })
    ov
    python313
    libqalculate
    ripgrep
    river
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
        "rustc-codegen-cranelift-preview"
      ];
    }))
    slurp
    tree
    wf-recorder
    wl-clipboard
    
    calibre
    cosmic-files
    fflogs
    gimp3
    libreoffice-fresh
    mullvad-vpn
    prismlauncher
    qbittorrent
    quickshell
    qview
    inputs.nixos-xivlauncher-rb.packages.${pkgs.stdenv.hostPlatform.system}.xivlauncher-rb
  ];

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.eza.enable = true;
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

  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox"; # home.stateVersion < 26.05 behavior
  };

  programs.fzf = {
    enable = true;
  };
  catppuccin.fzf.enable = true;

  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      init.defaultBranch = "main";
      core.editor = "code --wait";
    };
  };

  programs.mpv = {
    enable = true;
    config = {
      background-color = "#000000";
      osd-back-color = "#11111b";
      osd-border-color = "#11111b";
      osd-color = "#cdd6f4";
      osd-shadow-color = "#1e1e2e";
      keep-open = true;
      screenshot-format = "png";
    };
    scriptOpts.osc = {
      seekbarkeyframes = false;
    };
    bindings = {
      MBTN_LEFT = "no-osd cycle pause";
    };
  };

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

  services.blueman-applet.enable = true;

  xdg.portal.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "firefox.desktop";
      "application/epub+zip" = "calibre-ebook-viewer.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
      "inode/directory" = "yazi.desktop";
      "text/html" = "firefox.desktop";
      "text/plain" = "code.desktop";
    };
  };


  catppuccin = {
    enable = true;
    autoEnable = false;
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
      AQ_DRM_DEVICES = "/dev/dri/hyprland-gpu";
    };

    # DO NOT CHANGE
    stateVersion = "24.11";
  };
}
