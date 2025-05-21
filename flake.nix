{
  description = "AeoNix";

  # === Inputs ===
  inputs = {

    # Base nixpkgs url
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

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
    hyprland.url = "github:/hyprwm/Hyprland?submodules=1&ref=v0.48.0";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.48.0";
      inputs.hyprland.follows = "hyprland";
    };
  };

  # === Outputs ===
  outputs = { self, nixpkgs, chaotic, home-manager, nix-flatpak, ... }@inputs:
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
            inherit inputs chaotic username;
            flakeRoot = ./.;
          };

          modules = [
            # === Core System Configuration File ===
            ./nixos/${systemName}/configuration.nix
            chaotic.nixosModules.default
            {
            nix.settings = {
              substituters = [ 
                "https://cache.nixos.org/"
                "https://hyprland.cachix.org"
                ];
              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                ];
              };
            }

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