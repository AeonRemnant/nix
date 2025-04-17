# === Arguments ===
{ config, pkgs, inputs, username, lib, flakeRoot, ... }:

{
  # === Imports ===
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix 
    ../../modules/system/core.nix 
    ../../modules/system/nvidia.nix 
    ../../modules/system/gaming.nix 
  ];

  # === Display Manager ===
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoLogin = {
      enable = true;
      user = "${username}";
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

  # === Hyprland ===
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [ inputs.Hyprspace.packages.${pkgs.system}.Hyprspace ];
  };
}