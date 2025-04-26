{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    salt
    salt-lint
    python3Packages.ipy
  ];

  nixpkgs.overlays = [
    (final: prev: {
      salt = prev.salt.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ 
          final.python3Packages.ipy 
          final.python3Packages.saltext-proxmox
          ];
      });
    })
  ];

  services.salt.master = {
    enable = true;
    configuration = {
      cloud_providers_dir = "/home/aeon/git/aeonremnant/anvil/salt/cloud.providers.d";
      cloud_profiles_dir = "/home/aeon/git/aeonremnant/anvil/salt/cloud.profiles.d";
    };
  };
  networking.firewall.allowedTCPPorts = [ 4505 4506 ];
}