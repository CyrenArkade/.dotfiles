{ inputs, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    greetd-mini-wl-greeter
    cage
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = lib.strings.concatStringsSep " " [
          "${pkgs.cage}/bin/cage -s -- {pkgs.greetd-mini-wl-greeter}/bin/greetd-mini-wl-greeter"
          "--background-color 1e1e2e --text-color cdd6f4 --outline-color 11111b --entry-color 181825 --border-color b4befe"
          "--user cyren --command ${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/Hyprland"
        ];
        user = "cyren";
      };
    };
  };
}