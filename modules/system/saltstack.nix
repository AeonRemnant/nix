{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    salt
    salt-lint
  ];
  services.salt.master = {
    enable = true;
    config = ''
      cloud_providers_dir: /home/aeon/git/aeonremnant/salt/cloud.providers.d
      cloud_profiles_dir: /home/aeon/git/aeonremnant/salt/cloud.profiles.d
      cloud_maps: /home/aeon/git/aeonremnant/salt/cloud.map.d
    '';
  };
  networking.firewall.allowedTCPPorts = [ 4505 4506 ];
}