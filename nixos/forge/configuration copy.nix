{ config, pkgs, inputs, username, lib, ... }: 

{
  # === Imports ===
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/core.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/gaming.nix
  ];

  # === User Config ===
  users.users.aeon = {
    isNormalUser = true;
    description = "aeon";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    shell = pkgs.nushell;
  };

  # === System Config ===

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "forge";
  home-manager.backupFileExtension = "nixbak";
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
}