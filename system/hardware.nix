{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Not automatically detected
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  # Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024; # 16 GB
  }];
  zramSwap.enable = true;

  # Nvidia and power management
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = false;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

}
