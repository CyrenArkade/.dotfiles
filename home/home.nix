{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin

    ./hypr/hyprland.nix
    ./kitty/kitty.nix
    ./neovim/neovim.nix
    ./vesktop/vesktop.nix

    ./gtk.nix
    ./qt.nix

    ./cursor.nix
    ./fonts.nix

    ./fish.nix
    ./starship.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    fd
    ffmpeg
    file
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
    
    gimp3
    kdePackages.dolphin
    lutris
    mullvad-vpn
    prismlauncher # jdk 8, 17, 21
    qbittorrent
    xivlauncher
  ];

  xdg.portal.enable = true;

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.eza.enable = true;
  programs.firefox.enable = true;
  programs.vscode.enable = true;
  

  programs.bat.enable = true;
  catppuccin.bat.enable = true;

  programs.btop = {
    enable = true;
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


  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
  };

  nixpkgs.config.allowUnfree = true;

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
