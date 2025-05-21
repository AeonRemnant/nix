{ config, pkgs, ... }:

{
  # === System Packages ===
  environment.systemPackages = with pkgs; [
    keychain
  ];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;
}