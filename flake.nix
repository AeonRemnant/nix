{
  description = "AeoNix";

  inputs = {
    # === Nix Packages collection ===
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # === Home Manager ===
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # === Apps ===
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, nix-flatpak, }@inputs:
    let
      systemName = "forge";
      username = "aeon";
      systemArch = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${systemArch};
    in {
      nixosConfigurations = {
        "${systemName}" = nixpkgs.lib.nixosSystem {
          system = systemArch;
          specialArgs = {
            inherit inputs username;
            flakeRoot = ./.;
          };
          modules = [

            # === Nix module imports ===
            ./nixos/${systemName}/configuration.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs username; };
              home-manager.users.${username} = import ./home/${username}/home.nix;
            }
          ];
        };
      };

      homeConfigurations = {
        "${username}@${systemName}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs username; };
          modules = [ ./home/${username}/home.nix ];
        };
      };
    };
}