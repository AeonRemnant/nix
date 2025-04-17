{ config, pkgs, lib, username, ... }:

{
  # === Login ===
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
    ];
  };

  services = {
  
  xserver.enable = false;

  greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getBin config.wayland.windowManager.hyprland.package}/bin/Hyprland";
        user = "${username}";
        };
      };
    };
  };
}