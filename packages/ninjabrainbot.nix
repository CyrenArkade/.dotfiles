{
  stdenv,
  lib,
  fetchurl,
  makeBinaryWrapper,
  jre,
  libxkbcommon,
  libX11,
  libXt,
}:

stdenv.mkDerivation rec {
  pname = "NinjaBrain-Bot";
  version = "1.5.2";

  src = fetchurl {
    url = "https://github.com/Ninjabrain1/${pname}/releases/download/${version}/${pname}-${version}.jar";
    hash = "sha256-mAmfYyGpDUrOwTQA6G0F96+NYOVjnC84Qn6WjccUUP8=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeBinaryWrapper ];
  buildInputs = [
    libxkbcommon
    libX11
    libXt
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    makeWrapper ${jre}/bin/java $out/bin/ninjabrainbot \
      --add-flags "-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel -jar $src" \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath buildInputs}

    runHook postInstall
  '';
}
