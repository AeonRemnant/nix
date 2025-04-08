{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    gamemode
  ];

  # === Gamemode === 
  programs.gamemode.enable = true;
}
