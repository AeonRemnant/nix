{ config, pkgs, lib, ... }:

{
  # === Hyprland config ===
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}