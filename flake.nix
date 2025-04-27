{
  description = "AeoNix";

  # === Inputs ===
  inputs = {

    # Base nixpkgs url
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager support
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen Browser until it gets a dedicated nixpkg
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flatpak support
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    # Hyprland support
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    # Gaming
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  # === Outputs ===
  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs:
    let
      # === Common Variables ===
      systemName = "forge";
      username = "aeon";
      systemArch = "x86_64-linux";

      # === Package Sets ===
      pkgs = import nixpkgs {
         system = systemArch;
         config.allowUnfree = true;
      };

      # === Libraries ===
      lib = nixpkgs.lib;

    in {
      # === NixOS Configurations ===
      nixosConfigurations = {
        "${systemName}" = lib.nixosSystem {
          system = systemArch;


          specialArgs = {
            inherit inputs username;
            flakeRoot = ./.;
          };

          modules = [
            # === Core System Configuration File ===
            ./nixos/${systemName}/configuration.nix

            # === Third-Party NixOS Modules ===
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.home-manager.nixosModules.home-manager
          ];
        };
      };

      homeConfigurations.aeon = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs username;
          flakeRoot = ./.;
        };
        modules = [
          ./home/aeon/home.nix
        ];
      };
    };
}