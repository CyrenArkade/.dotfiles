{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    
    # ./display_managers/sddm.nix
    # ./display_managers/greetd.nix
    ./display_managers/ly.nix
    ./plymouth.nix
  ];

  environment.systemPackages = with pkgs; [
    gnome-keyring
  ];

  programs.nix-ld.enable = true;
  programs.fish.enable = true; # here AND home-manager
  programs.steam.enable = true;
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };

  services.blueman.enable = true;
  
  services.gnome.gnome-keyring.enable = true;

  services.mullvad-vpn.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "cyren" ];
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.upower.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    # storageDriver = "btrfs";
  };

  fonts.enableDefaultPackages = true;

  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
  };

  # environment.sessionVariables = {};

  boot = {
    # Use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "ntsync"
    ];
  };

}
