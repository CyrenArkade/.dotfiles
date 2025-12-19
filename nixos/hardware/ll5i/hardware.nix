{ inputs, config, pkgs, ... }:

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
  };

  # Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024; # 16 GB
  }];
  zramSwap.enable = true;

  # Graphics
  services.xserver.videoDrivers = [
    "nvidia"
  ];
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ];
  };
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  # Remap copilot to ctrl
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          "f23+leftshift+leftmeta" = "layer(control)"; # copilot to ctrl
        };
      };
    };
  };
}
