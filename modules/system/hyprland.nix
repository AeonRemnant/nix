{ config, pkgs, lib, ... }:

{
  # Enable Wayland session and related tools if needed system-wide
  programs.hyprland = {
     enable = true;
     xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
     xdg-desktop-portal-hyprland
  ];

  # === Environment ===
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}