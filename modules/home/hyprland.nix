{ config, pkgs, lib, ... }:

{
  # === Packages ===
  home.packages = with pkgs; [
    hyprlandPlugins.hyprspace
    hyprpaper
    hyprls
    hyprcursor
    mako
    walker
    grim
    slurp
    wl-clipboard
    nwg-look
  ];

  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprspace
    ];
  };

  # === Mako Config ===
  services.mako = {
    defaultTimeout = 4000;
  };

  # === Services ===
  services.mako.enable = true; 

  # === Environment ===
  home.sessionVariables = {
    
    # Nvidia flags
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