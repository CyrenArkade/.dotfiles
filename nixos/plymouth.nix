{ pkgs, ... }:

{
  # nixpkgs.overlays = [
  #   # Overlay plymouth to call plymouth quit with --retain-splash.
  #   (final: prev: {
  #     plymouth = prev.plymouth.overrideAttrs ( prevAttrs: {
  #       postInstall = ''
  #         ${prevAttrs.postInstall}
  #         sed -i 's|/bin/plymouth quit|/bin/plymouth quit --retain-splash|g' $out/lib/systemd/system/plymouth-quit.service
  #       '';
  #     });
  #   })
  # ];

  # https://wiki.nixos.org/wiki/Plymouth
  boot = {
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        # 2, 18, 49, 55, 59, 62 are all pretty
        # firefox https://raw.githubusercontent.com/adi1090x/files/master/plymouth-themes/previews/{2,18,49,55,59,62}.gif
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "plymouth.force-scale=1"
    ];

    # Hide generation selection
    # It will still appear when a key is pressed
    loader.timeout = 0;
  };
}