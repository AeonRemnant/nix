{ inputs, username, hy3, ... }:

{
  _module.args = {
    hy3 = inputs.hy3;
  };

  # === Imports ===
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ../../modules/home/core.nix
    ../../modules/home/dotfiles.nix
    ../../modules/home/gaming.nix
    ../../modules/home/hyprland.nix 
    ../../modules/home/emacs.nix
  ];

  # Home
  home.username = username;
  home.homeDirectory = "/home/aeon";

  # Nix
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
