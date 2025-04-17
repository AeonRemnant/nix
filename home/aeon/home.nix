{ config, pkgs, inputs, username, ... }:

{
  # === Imports ===
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    # inputs.hyprland.homeManagerModules.default
    # ../../modules/home/core.nix
    # ../../modules/home/dotfiles.nix
    # ../../modules/home/gaming.nix
    # ../../modules/home/hyprland.nix
  ];

  # === System Config ===
  programs.hyprland.enable = true;

  # Home
  home.username = username;
  home.homeDirectory = "/home/aeon";

  # Nix
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
