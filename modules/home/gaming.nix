{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    heroic
    lutris
    protonup-qt
    mangohud
  ];
}