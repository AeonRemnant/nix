{ config, pkgs, chaotic, lib, ... }:

{
  # === Chaotic System Packages ===
  environment.systemPackages = [
    chaotic.linuxPackages_cachyos-rc
  ];

  boot.kernelPackages = chaotic.linuxPackages_cachyos-rc;
}