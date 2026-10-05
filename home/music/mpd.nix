{ config, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };

  programs.rmpc.enable = true;
  xdg.configFile = {
    "rmpc/config.ron".source = ./rmpc-config.ron;
    "rmpc/themes/theme.ron".source = ./rmpc-theme.ron;
  };
}