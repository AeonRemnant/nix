{
  description = "AeoNix";

  # === Inputs ===
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # === Application-specific Flakes ===
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
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
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs username flakeRoot;
        };
        modules = [
          ./home/aeon/home.nix
  ];
};
    };
}