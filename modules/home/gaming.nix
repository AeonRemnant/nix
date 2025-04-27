{ config, pkgs, lib, ... }: let
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {

  home.packages = with pkgs; [
    steam
    heroic
    lutris
    protonup-qt
    mangohud

    nix-gaming.packages.${pkgs.hostPlatform.system}.faf-client
  ];
}