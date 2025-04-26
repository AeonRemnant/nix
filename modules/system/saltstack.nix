{ config, pkgs, ... }:

let
  saltConfDir = "/srv/salt/config";
  saltLogDir = "/var/log/salt";
  saltCacheDir = "/var/cache/salt";
in
{
  environment.systemPackages = with pkgs; [
    salt
    salt-lint
  ];
  services.salt.master = {
    enable = true;
    configDir = saltConfDir;
    logFile = "${saltLogDir}/master";
    keyDir = "${saltCacheDir}/master/pki/master";
    pidFile = "/run/salt/master.pid";
    extraConfig = ''
      file_roots:
        base:
          - /srv/salt/states  # Location for your state files (.sls)
      pillar_roots:
        base:
          - /srv/salt/pillar # Location for your pillar data (.sls/.yml)
    '';
  };
  systemd.tmpfiles.rules = [
    "d ${saltConfDir} 0750 root root -"
    "d ${saltLogDir} 0750 root root -"
    "d ${saltCacheDir}/master 0750 root root -"
    "d ${saltCacheDir}/master/pki 0750 root root -"
    "d ${saltCacheDir}/minion 0750 root root -"
    "d ${saltCacheDir}/minion/pki 0750 root root -"
    "d /srv/salt/states 0755 root root -"
    "d /srv/salt/pillar 0750 root root -"
    "d /run/salt 0755 root root -"
  ];
  networking.firewall.allowedTCPPorts = [ 4505 4506 ];
}