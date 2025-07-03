{ inputs, pkgs, ... }:

{
  services.displayManager = {
    sessionPackages = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    ];
    autoLogin = {
      enable = true;
      user = "cyren";
    };
    sddm = {
      enable = true;
      wayland.enable = true;
      autoLogin.relogin = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        kdePackages.qt5compat
      ];
    };
  };
}

# { pkgs, ... }:

# let
#   background = pkgs.runCommand "background-image" {} ''
#     cp ${./xingyejin.jpg} $out
#   '';
#   custom-sddm-astronaut = pkgs.sddm-astronaut.override {
#     embeddedTheme = "purple_leaves";
#     themeConfig = {
#       Background = "${background}";
#       PartialBlur = false;
#     };
#   };
# in {
#   services.displayManager.sddm = {
#     enable = true;
#     wayland.enable = true;
#     theme = "sddm-astronaut-theme";
#     package = pkgs.kdePackages.sddm;
#     settings = {
#       Theme = {
#         CursorTheme = "Fuchsia";
#         CursorSize = 24;
#       };
#     };
#     extraPackages = with pkgs; [
#       custom-sddm-astronaut
#     ];
#   };

#   environment.systemPackages = with pkgs; [
#     custom-sddm-astronaut
#   ];
# }


# { inputs, pkgs, ... }:

# let
#   background = pkgs.runCommand "sddm-background" {} ''
#     cp ${../../images/xingyejin.jpg} $out
#   '';
#   custom-sddm-where = pkgs.where-is-my-sddm-theme.override {
#     themeConfig.General = {
#       background = "${background}";
#       backgroundMode = "fill";
      
#       passwordCharacter = "•";
#       passwordFontSize = 48;
#       passwordCursorColor = "#f5e0dc";
#       passwordInputBackground = "#801e1e2e";

#       showSessionsByDefault = true;
#       sessionsFontSize = 12;

#       basicTextColor = "#cdd6f4";
#     };
#   };
# in {
#   environment.systemPackages = with pkgs; [
#     custom-sddm-where
#   ];

#   services.displayManager = {
#     sessionPackages = [
#       inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
#     ];
#     sddm = {
#       enable = true;
#       wayland.enable = true;
#       theme = "where_is_my_sddm_theme";
#       package = pkgs.kdePackages.sddm;
#       settings = {
#         Theme = {
#           CursorTheme = "Fuchsia";
#           CursorSize = 24;
#         };
#       };
#       extraPackages = with pkgs; [
#         kdePackages.qt5compat
#       ];
#     };
#   };
# }