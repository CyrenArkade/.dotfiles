{
  pkgs,
  fetchFromGitHub,
  stdenv,
}:

stdenv.mkDerivation {
  pname = "still";
  version = "0.0.8";
  src = fetchFromGitHub {
    owner = "faergeek";
    repo = "still";
    rev = "9be3bcc95123fe45ddd2720164e2935ecbef4d0b";
    sha256 = "sha256-Ld93xCTgxK4NI4aja6VBYdT9YJHDtoHuiy0c18ACv6M=";
  };

  nativeBuildInputs = with pkgs; [ meson ninja pkg-config scdoc ];

  buildInputs = with pkgs; [ pixman wayland wayland-protocols wayland-scanner ];

  mesonFlags = [ "-Dwrap_mode=nodownload" ];
}
