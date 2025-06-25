{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland/v0.49.0";
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    hypredge = {
      url = "github:CyrenArkade/hypredge";
      # url = "git+file:///home/cyren/dev/cpp/hypredge";
      inputs.hyprland.follows = "hyprland";
    };
    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in {
      
      # sudo nixos-rebuild switch --flake .
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [ ./system/configuration.nix ];
        };
      };

      # home-manager switch --flake .
      homeConfigurations = {
        cyren = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/home.nix ];
        };
      };

    };
}
