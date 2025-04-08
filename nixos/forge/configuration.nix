# NixOS configuration for host 'forge'

# === Arguments ===
# Passed from flake.nix via 'specialArgs'
{ config, pkgs, inputs, username, lib, flakeRoot, ... }:

{
  # === Imports ===
  # Import other NixOS modules and hardware configuration
  imports = [
    ./hardware-configuration.nix        # Generated hardware settings
    ../../modules/system/core.nix       # Custom core system settings module
    ../../modules/system/hyprland.nix   # Custom Hyprland module
    ../../modules/system/nvidia.nix     # Custom Nvidia module
    ../../modules/system/gaming.nix     # Custom gaming-related module
  ];

  # === System Config ===
  # Basic system identification and state version
  networking.hostName = "forge";           # System hostname
  system.stateVersion = "24.11";         # NixOS state version for compatibility

  # === Bootloader ===
  # Configure systemd-boot for EFI systems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # === Nix Settings ===
  # Enable necessary experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow installation of proprietary/non-free software
  nixpkgs.config.allowUnfree = true;

  # === User Config ===
  # Define the primary system user
  users.users.${username} = { # Use 'username' variable passed from flake.nix
    isNormalUser = true;
    description = "aeon";
    # Groups for necessary permissions (hardware, admin, etc.)
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    shell = pkgs.nushell; # Set the default login shell
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
    };
  };

  # === Hardware / Drivers ===
  # (Likely configured in imported modules like nvidia.nix)

  # === Services / Applications ===
  # (Likely configured in imported modules like core.nix, hyprland.nix)

  # === Gaming Settings ===
  # (Likely configured in gaming.nix)

}