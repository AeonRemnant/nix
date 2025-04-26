{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    salt
    salt-lint
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