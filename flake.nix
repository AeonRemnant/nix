{
  description = "AeoNix"; # User's description

  # === Inputs ===
  # Defines external Nix code dependencies (other flakes)
  inputs = {
    # Core Nix packages collection (tracking nixos-unstable)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager for managing user environments and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      # Ensure Home Manager uses the same nixpkgs version as the system
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # === Application-specific Flakes ===
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs"; # Use same nixpkgs
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak"; # Flatpak support
    };
  };

  # === Outputs ===
  # Defines what this flake provides (NixOS systems, HM profiles, etc.)
  outputs = { self, nixpkgs, home-manager, ... }@inputs: # Capture all inputs in 'inputs' attrset
    let
      # === Common Variables ===
      # Define reusable values for system and user configuration
      systemName = "forge";
      username = "aeon";
      systemArch = "x86_64-linux";

      # === Package Sets ===
      # Central definition of the package set based on architecture
      pkgs = nixpkgs.legacyPackages.${systemArch};

      # === Libraries ===
      # Convenience access to Nixpkgs library functions
      lib = nixpkgs.lib;

    in {
      # === NixOS Configurations ===
      # Defines complete NixOS system installations.
      # Build with: sudo nixos-rebuild switch --flake .#${systemName}
      nixosConfigurations = {
        "${systemName}" = lib.nixosSystem {
          system = systemArch;

          # Arguments passed down to all NixOS modules for this system.
          # Modules can access these via their function arguments.
          specialArgs = {
            inherit inputs username; # Pass flake inputs and username
            flakeRoot = ./.;       # Pass path to the flake's root directory
          };

          modules = [
            # === Core System Configuration File ===
            # Contains host-specific settings, imports hardware config, etc.
            ./nixos/${systemName}/configuration.nix

            # === Third-Party NixOS Modules ===
            # Integrate features from other flakes.
            inputs.nix-flatpak.nixosModules.nix-flatpak  # Flatpak support module
            inputs.home-manager.nixosModules.home-manager # Enables Home Manager integration

            # Note: Specific Home Manager settings (user definitions, etc.)
            # are now handled within ./nixos/${systemName}/configuration.nix
          ];
        };
      }; # End nixosConfigurations

      # === Home Manager Configurations ===
      # Defines standalone user environment configurations.
      # Useful for non-NixOS systems or testing.
      # Build with: home-manager switch --flake .#${username}@${systemName}
      homeConfigurations = {
        # Unique name for the standalone configuration (e.g., user@host)
        "${username}@${systemName}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs; # Use the same package set for consistency

          # Arguments passed down to all Home Manager modules for this profile.
          # Modules access these via their function arguments.
          extraSpecialArgs = {
            inherit inputs username; # Pass flake inputs and username
            flakeRoot = ./.;       # Pass flake root path (needed for dotfile paths etc.)
          };

          modules = [
            # User's main Home Manager configuration file
            ./home/${username}/home.nix
          ];
        };
      }; # End homeConfigurations
    }; # End outputs
}