{
  writeShellApplication,
  quickshell,
  jq,
}:

writeShellApplication {
  name = "strawb";
  runtimeInputs = [
    quickshell
    jq
  ];
  text = builtins.readFile ./scripts/strawb.sh;
}
