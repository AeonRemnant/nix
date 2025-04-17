{ config, pkgs, lib, username, ... }:

{
  environment.systemPackages = with pkgs; [
    greetd.greetd
    greetd.regreet
  ];

  greetd.greetd = {
    enable = true;
    package = pkgs.greetd.regreet;
    settings = {
      default_session = {
        command = "${pkgs.systemd}/bin/systemctl --user start graphical-session.target";
        user = "${username}";
      };
    };
  };
}