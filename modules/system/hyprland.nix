{ config, pkgs, lib, ... }:

{
  # === Hyprland config ===
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      # Load hyprspace plugin
      plugin = ${pkgs.hyprlandPlugins.hyprspace}/lib/hyprland/plugins/hyprspace.so
      # Add any other essential plugins here
    '';
  };
}