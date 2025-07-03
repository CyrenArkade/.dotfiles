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

        # Skip building the other cursors
        sed -i 's/create svg-dark//g' build.sh
        sed -i 's/create svg-light-nord//g' build.sh
        sed -i 's/create svg-dark-nord//g' build.sh
      '';
      buildPhase = ''
        find src/svg-light -type f -exec sed -i 's/#333333/#11111b/g' {} +
        find src/svg-light -type f -exec sed -i 's/#ffffff/#b4befe/g' {} +
        ./build.sh
      '';
      installPhase = ''
        install -dm 755 $out/share/icons
        mv dist-light $out/share/icons/graphite-light
      '';
    };
  };
}