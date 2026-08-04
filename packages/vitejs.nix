{
  vitejs,
  fetchPnpmDeps,
  pnpm_10,
}:

vitejs.overrideAttrs (final: prev: {
  pnpmDeps = fetchPnpmDeps {
    inherit (final)
      pname
      version
      src
      pnpmWorkspaces
      ;
    pnpm = pnpm_10;
    fetcherVersion = 3;
    hash = "sha256-02s37dcEvxFlaGO+RNxTMPuTV0/sx7hiX1Nzc3A/qro=";
  };
})
