{ config, pkgs, lib, ... }:

{
  # === Packages ===
  home.packages = with pkgs; [
    hyprpaper
    hyprcursor
    mako
    walker
    grim
    slurp
    hyprswitch
    hyprlandPlugins.hyprexpo
    hyprlandPlugins.hyprspace
    wl-clipboard
    nwg-look
  ];

  # === Wayland Config ===
  wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hyprspace
    pkgs.hyprlandPlugins.hyprexpo
  ];

  wayland.windowManager.hyprland.settings = {
    debug.disable_logs = false;
  };

  # === Mako Config ===
  services.mako = {
    defaultTimeout = 5000;
  };

  # === Services ===
  services.mako.enable = true; 

  # === Nvidia Flags ===
  home.sessionVariables = {
  LIBVA_DRIVER_NAME = "nvidia";
  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  GBM_BACKEND = "nvidia-drm";
  ELECTRON_OZONE_PLATFORM_HINT = "auto";
  QT_QPA_PLATFORM = "wayland";
  QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}