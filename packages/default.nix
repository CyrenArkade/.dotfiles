final: prev:

let
  lib = prev.lib;
  files = builtins.readDir ./.;

  packageFiles = lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
  ) files;
  overlayPackages = lib.mapAttrs'
    (name: _:
      let
        pkgName = lib.removeSuffix ".nix" name;
        extraArgs = if builtins.hasAttr pkgName prev then { ${pkgName} = prev.${pkgName}; } else {};
      in {
        name = pkgName;
        value = prev.callPackage (./. + "/${name}") extraArgs;
      }
    )
    packageFiles;
in overlayPackages