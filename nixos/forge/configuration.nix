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
  # Configure Home Manager integration for NixOS
  home-manager = {
    # Use the same nixpkgs instance as the system
    # pkgs = pkgs; # Usually inherited automatically

    # Allow HM to use system-wide packages
    useGlobalPkgs = true;
    # Allow HM to install user-specific packages
    useUserPackages = true;
    # Set backup extension for dotfiles managed by Home Manager
    backupFileExtension = "nixbak";

    # Arguments passed down to Home Manager modules for users defined below
    extraSpecialArgs = {
      # Pass arguments received from flake.nix's 'specialArgs'
      inherit inputs username flakeRoot;
    };

    # Define users managed by Home Manager on this system
    users.${username} =
      # Import the user's home.nix file. Assumes it returns the full user config attrset.
      # Explicitly pass arguments needed by home.nix. Adjust the list as needed.
      import ../../home/${username}/home.nix {
        inherit pkgs lib config inputs username flakeRoot; # Pass common args
      };
      # --- ALTERNATIVE (if home.nix is a standard module): ---
      # users.${username} = { imports = [ ../../home/${username}/home.nix ]; };

  }; # End home-manager

  # === Hardware / Drivers ===
  # (Likely configured in imported modules like nvidia.nix)

  # === Services / Applications ===
  # (Likely configured in imported modules like core.nix, hyprland.nix)

  # === Gaming Settings ===
  # (Likely configured in gaming.nix)

}