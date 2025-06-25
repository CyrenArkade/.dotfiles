{ inputs, ... }:

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

  # Power management
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";

  # Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024; # 16 GB
  }];
  zramSwap.enable = true;

  # Nvidia
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
