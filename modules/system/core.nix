{ config, pkgs, ... }:

{
  # === Basic System Setup ===
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  # === System Packages ===
  environment.systemPackages = with pkgs; [
    greetd.greetd
    flatpak
    git
    wget
    xwayland
    hyprpolkitagent
    gtk4-layer-shell
    upower
    tree
    btop
    vulkan-tools
    btrfs-progs
    nvfancontrol
    xfce.thunar
    nixos-anywhere
    easyeffects
    xdg-utils
  ];

fonts.packages = with pkgs; [
    fira-code
    noto-fonts-color-emoji

    # Fallbacks
    noto-fonts
    noto-fonts-cjk
  ];

  # === System Settings ===
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # === Environment ===
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # === Security ===
  security.polkit.enable = true;

  # === Services ===
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Flatpak
  services.flatpak.enable = true;
  services.flatpak.update.onActivation = true;
  # System
  services.dbus.enable = true;
  networking.networkmanager.enable = true;
  services.upower.enable = true;
  # Thunar
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  # === Boot Config ===
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  # === Kernel Settings ===
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true;
}