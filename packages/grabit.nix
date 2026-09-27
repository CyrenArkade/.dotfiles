{
  stdenv,
  fetchFromGitHub,
  pkgs,
}:

stdenv.mkDerivation {
  pname = "grabit";
  version = "0.7.0";
  src = fetchFromGitHub {
    owner = "Creationsss";
    repo = "grabit";
    rev = "9afccc318605536ce4552030e398a5270745f108";
    hash = "sha256-WAFY4E0F2GwXYqmuxoO3S8R/OsoiyyZTrUkMbmmW2dw=";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    wayland-scanner
    ffmpeg-headless
  ];

  buildInputs = with pkgs; [
    json_c
    curl
    file
    wayland
    libpng
    cairo
    libxkbcommon
    dbus
  ];
}

