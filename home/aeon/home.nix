{ config, pkgs, inputs, username, ... }:

{
  # === Imports ===
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.hyprland.homeManagerModules.default
    ../../modules/home/core.nix
    ../../modules/home/dotfiles.nix
    ../../modules/home/gaming.nix
    # ../../modules/home/hyprland.nix
  ];

  # === System Config ===

  # Home
  home.username = username;
  home.homeDirectory = "/home/aeon";

  # Nix
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # === Hyprland config ===
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    plugins = [
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    ];
  };
}
