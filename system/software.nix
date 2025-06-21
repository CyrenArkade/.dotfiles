{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ./display_managers/sddm.nix
    # ./display_managers/greetd.nix
    # ./display_managers/ly.nix
  ];

  environment.systemPackages = with pkgs; [
    fuchsia-cursor
  ];

  programs.nix-ld.enable = true;
  programs.fish.enable = true; # here AND home-manager
  programs.steam.enable = true;

  services.openssh.enable = true;

  fonts.enableDefaultPackages = true;

  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
  };

  environment.sessionVariables = {
    # Not set before kitty is launched, so it won't appear in ctrl+f
    # Needs to be set here, not through home manager.
    FZF_DEFAULT_OPTS = "--color bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4,header:#b4befe,hl:#b4befe,hl+:#b4befe,info:#b4befe,marker:#b4befe,pointer:#b4befe,prompt:#b4befe,spinner:#f5e0dc";
  };

}
