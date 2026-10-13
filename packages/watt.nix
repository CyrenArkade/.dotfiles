{
  watt,
  fetchFromGitHub,
  rustPlatform,
}:

watt.overrideAttrs (prev: rec {
  version = "707ae350";

  src = fetchFromGitHub {
    owner = "notashelf";
    repo = "watt";
    rev = "707ae3507b995eac6a015d877156aa4c3bc92ecd";
    hash = "sha256-hPSY5xQ5IziQrmBixtmhvzUHIHl8nIgGzxKBOlAktz8=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-7qkujZk9dv5CUfTN42ytP4Qj/SyWbk95uDd7NoETyDw=";
  };

  nativeInstallCheckInputs = [];
})
