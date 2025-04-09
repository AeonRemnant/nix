{ config, pkgs, lib, ... }: 

{

  # === Basic System Setup ===
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  # === Greetd config ===
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
    };
  };

  # === System Packages ===
  environment.systemPackages = with pkgs; [
    flatpak
    git
    wget
    hyprland
    xwayland
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    gtk4-layer-shell
    upower
    tree
    btop
    vulkan-tools
  ];

  fonts.packages = with pkgs; [
    fira-code
  ];

  # === System Settings ===
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # === Security ===
  security.polkit.enable = true;

  # === Environment ===
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
  services.openssh.enable = true;
  services.dbus.enable = true;
  networking.networkmanager.enable = true;
  services.upower.enable = true;
  services.dconf.enable = true;

  # === Programs ===
  programs.hyprland.enable = true;
}