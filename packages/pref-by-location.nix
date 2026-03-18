{
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  name = "pref-by-location";
  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "pref-by-location.yazi";
    rev = "68f006da24870761a3926eed13c877ce2b4a4559";
    hash = "sha256-mmEQBigbHkxmRBQDEt4WSqlZGC+200k+4/4tjUk+484=";
  };
  installPhase = "cp -r . $out/";
}