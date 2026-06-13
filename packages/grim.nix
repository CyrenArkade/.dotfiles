{
  grim
}:

grim.overrideAttrs (prev: {
  patches = (prev.patches or []) ++ [
    ./patches/scaling.patch
  ];
})
