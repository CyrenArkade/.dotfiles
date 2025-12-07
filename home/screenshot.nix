{ lib, pkgs, ... }:

let
  still = pkgs.stdenv.mkDerivation {
    pname = "still";
    version = "0.0.8";
    src = pkgs.fetchFromGitHub {
      owner = "faergeek";
      repo = "still";
      rev = "9be3bcc95123fe45ddd2720164e2935ecbef4d0b";
      sha256 = "sha256-Ld93xCTgxK4NI4aja6VBYdT9YJHDtoHuiy0c18ACv6M=";
    };

    nativeBuildInputs = with pkgs; [ meson ninja pkg-config scdoc ];

    buildInputs = with pkgs; [ pixman wayland wayland-protocols wayland-scanner ];

    mesonFlags = [ "-Dwrap_mode=nodownload" ];
  };
  takeScreenshot = pkgs.writeShellScript "takeScreenshot" ''
    folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
    fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
    export fullPath="$folderName/$fileName"

    mkdir -p "$folderName"

    function whileStill() {
      set -e
    
      read x y w h < <(${pkgs.slurp}/bin/slurp -d -b 00000060 -c b4befeff | sed 's/[+,x]/ /g')
      sx=$(echo "$x * 1.25 + 0.5" | ${pkgs.bc}/bin/bc)
      sy=$(echo "$y * 1.25 + 0.5" | ${pkgs.bc}/bin/bc)
      sw=$(echo "$w * 1.25 + 0.5" | ${pkgs.bc}/bin/bc)
      sh=$(echo "$h * 1.25 + 0.5" | ${pkgs.bc}/bin/bc)

      ${pkgs.grim}/bin/grim "$fullPath"

      echo ''${sw}x''${sh}+''${sx}+''${sy}
    }
    export -f whileStill

    crop="$(${still}/bin/still -p -c whileStill)"

    if [[ -z "$crop" || ! -f "$fullPath" ]]; then
        exit
    fi
    
    ${pkgs.imagemagick}/bin/magick "$fullPath" -crop "$crop" "$fullPath"

    ${pkgs.wl-clipboard}/bin/wl-copy < "$fullPath"

    action=$(${pkgs.libnotify}/bin/notify-send "Saved $fullPath" -u low -t 5000 --action=open=Open --action=edit=Edit)
    if [ "$action" = 'open' ]; then
      ${pkgs.xdg-utils}/bin/xdg-open "$folderName"
    elif [ "$action" = 'edit' ]; then
      ${pkgs.satty}/bin/satty -f "$fullPath" -o "$fullPath"
    fi
  '';
in {
  xdg.configFile."satty/config.toml".source = (pkgs.formats.toml {}).generate "config.toml" {
    general = {
      corner-roundness = 0;
      actions-on-enter = [ "save-to-clipboard" "save-to-file" "exit" ];
      actions-on-right-click = [ "exit" ];
      copy-command = "${pkgs.wl-clipboard}/bin/wl-copy";
      disable-notifications = true;
    };
    color-palette = {
      palette = [ "#f38ba8" "#fab387" "#f9e2af" "#a6e3a1" "#89dceb" "#89b4fa" "#b4befe" "#000000" "#ffffff" ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      ", mouse:276, exec, ${takeScreenshot}"
      ", Print, exec, ${takeScreenshot}" # printscreen
    ];
    layerrule = [
      "noanim, selection"
    ];
  };
}
