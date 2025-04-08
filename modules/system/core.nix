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
  ];

  fonts.packages = with pkgs; [
    fira-code
  ];

  # === System Settings ===
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
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
  services.openssh.enable = true;
  services.dbus.enable = true;
  networking.networkmanager.enable = true;

  # === Programs ===
  programs.hyprland.enable = true;


}