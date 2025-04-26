{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    salt
    salt-lint
  ];
  services.salt.master = {
    enable = true;
  };
  networking.firewall.allowedTCPPorts = [ 4505 4506 ];
}