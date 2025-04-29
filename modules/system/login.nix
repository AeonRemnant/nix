{ config, pkgs, lib, username, ... }:

{
  # environment.systemPackages = with pkgs; [
  #   greetd.greetd
  #   greetd.regreet
  # ];

  # services.greetd = {
  #   enable = true;
  #   package = pkgs.greetd.greetd;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.systemd}/bin/systemctl --user start graphical-session.target";
  #       user = "${username}";
  #     };
  #   };
  # };
}