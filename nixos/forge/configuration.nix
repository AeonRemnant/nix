# === Arguments ===
{ config, pkgs, inputs, username, lib, flakeRoot, ... }:

{
  # === Imports ===
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.hyprland.nixosModules.default
    ./hardware-configuration.nix 
    ../../modules/system/core.nix 
    ../../modules/system/nvidia.nix 
    ../../modules/system/gaming.nix 
  ];

  # === Display Manager ===
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getBin config.wayland.windowManager.hyprland.package}/bin/Hyprland";
        user = "${username}";
      };
    };
  };

  # === System Config ===
  networking.hostName = "forge";
  system.stateVersion = "24.11";

  # === Bootloader ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # === Nix Settings ===
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # === User Config ===
  users.users.${username} = {
    isNormalUser = true;
    description = "aeon";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    shell = pkgs.nushell;
  };

  # === Home Manager ===
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "nixbak";
    extraSpecialArgs = {
      inherit inputs username flakeRoot;
    };
    users.${username} = {
      imports = [ ../../home/${username}/home.nix ];

      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.11";
    };
  };
}