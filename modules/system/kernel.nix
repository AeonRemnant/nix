{ config, pkgs, chaotic, lib, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  services.scx.enable = true;
}