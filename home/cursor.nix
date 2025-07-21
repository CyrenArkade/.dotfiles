{ pkgs, ... }:

{
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   name = "Fuchsia";
  #   size = 24;
  #   package = pkgs.fuchsia-cursor;
  # };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "graphite-light";
    size = 24;
    package = pkgs.stdenv.mkDerivation {
      name = "custom-graphite-light";
      src = pkgs.fetchFromGitHub {
        owner = "vinceliuice";
        repo = "graphite-cursors";
        rev = "0249b10b36d30746f08fcb925d456fedb3c54b9d";
        sha256 = "sha256-Kopl2NweYrq9rhw+0EUMhY/pfGo4g387927TZAhI5/A=";
      };
      buildInputs = with pkgs; [
        xorg.xcursorgen
        inkscape
      ];
      patchPhase = ''
        patchShebangs ./build.sh

        # Skip building the other themes
        sed -i -E '/create (svg-dark|svg-light-nord|svg-dark-nord)/d' build.sh

        # Skip building the other sizes
        # Hyprland seems to currently be bugged, requiring 48px/2x in most places and 24px/1x in xwayland
        sed -i -E '/inkscape.*(x1_25|x1_5)/d' build.sh
        find src/config -type f -exec sed -i -E '/^(30|36)/d' {} +

        # Recolor to be lavender mocha
        find src/svg-light -type f -exec sed -i 's/#333333/#11111b/g' {} +
        find src/svg-light -type f -exec sed -i 's/#ffffff/#b4befe/g' {} +
      '';
      buildPhase = ''
        ./build.sh
      '';
      installPhase = ''
        install -dm 755 $out/share/icons
        mv dist-light $out/share/icons/graphite-light
      '';
    };
  };
}