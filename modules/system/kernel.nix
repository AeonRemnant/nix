{ config, pkgs, chaotic, lib, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true;
}