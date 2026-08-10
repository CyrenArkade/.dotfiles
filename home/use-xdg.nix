{ config, ... }:

let
  inherit (config.xdg) dataHome stateHome cacheHome;
in {
  xdg.enable = true;

  # Helpful list:
  # https://wiki.archlinux.org/title/XDG_Base_Directory
  home.sessionVariables = {
    ANDROID_USER_HOME = "${dataHome}/android";
    HISTFILE = "${stateHome}/bash/history";
    CARGO_HOME = "${dataHome}/cargo";
    NPM_CONFIG_CACHE = "${cacheHome}/npm";
    NPM_CONFIG_TMP = "${stateHome}/npm";
    PYTHON_HISTORY = "${stateHome}/python_history";
    RUSTUP_HOME = "${dataHome}/rustup";
  };
}

