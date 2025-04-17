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
    package = pkgs.greetd.tuigreet;
    settings = {
      initial_session = {
        command = "${config.users.users.${username}.shell}";
        user = "${username}";
      };
    };
    };
  };
}