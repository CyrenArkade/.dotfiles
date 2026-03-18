pkgs:

let
  lib = pkgs.lib;
  files = builtins.readDir ./.;

  packageFiles = lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
  ) files;
in lib.mapAttrs'
  (name: _: {
    name = lib.removeSuffix ".nix" name;
    value = pkgs.callPackage (./. + "/${name}") { };
  })
  packageFiles
