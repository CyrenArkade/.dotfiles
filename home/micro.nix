{ ... }: {

  programs.micro = {
    enable = true;
    settings = {
      tabstospaces = true;
    };
  };

  catppuccin.micro.enable = true;

  home.sessionVariables = {
      MICRO_TRUECOLOR = 1; # micro doesn't respect its own truecolor option
      EDITOR = "micro";
  };
}