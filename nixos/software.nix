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

  services.blueman.enable = true;
  
  services.gnome.gnome-keyring.enable = true;

  services.mullvad-vpn.enable = true;

  services.openssh.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    # storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  fonts.enableDefaultPackages = true;

  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
  };

  # environment.sessionVariables = {};

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "ntsync"
  ];

}
