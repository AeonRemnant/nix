{ config, pkgs, inputs, username, ... }:

{
  # === Imports ===
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ../../modules/home/core.nix
    ../../modules/home/dotfiles.nix
    ../../modules/home/gaming.nix
    ../../modules/home/hyprland.nix
  ];

  # === Dotfile Management ===
  home.file = {
    ".config/hypr" = {
      source = ./dotfiles/hyprland;
      recursive = true;
    };

    ".config/nushell" = {
      source = ./dotfiles/nushell;
      recursive = true;
    };

    ".config/walker" = {
      source = ./dotfiles/walker;
      recursive = true;
    };
  };

  # === System Config ===

  # Home
  home.username = username;
  home.homeDirectory = "/home/aeon";

  # Nix
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
