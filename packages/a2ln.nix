{
  pkgs,
  fetchFromGitHub,
  wrapGAppsHook3,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "a2ln";
  version = "1.1.15";

  src = fetchFromGitHub {
    repo = "a2ln-server";
    owner = "patri9ck";
    rev = version;
    hash = "sha256-5IrjegEHxd33fxJHumpWi9zXViEl2CmcGsCJdJlXCaA=";
  };

  pyproject = true;

  build-system = [
    wrapGAppsHook3
    python3Packages.setuptools
  ];

  dependencies = with pkgs; with python3Packages; [
    pillow
    pygobject3
    pyzmq
    qrcode
    setproctitle

    gobject-introspection
    libnotify
  ];

  strictDeps = false;
}
