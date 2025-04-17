{ config, pkgs, lib, ... }:

{
  # === Hyprland config ===
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      plugin = ${pkgs.hyprlandPlugins.hyprspace}/lib/hyprland/plugins/hyprspace.so
    '';
  };
}