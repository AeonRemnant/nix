{ pkgs, inputs, hy3, ... }:

{
  # === Packages ===
  home.packages = with pkgs; [
    hyprpaper
    hyprcursor
    hy3
    mako
    rofi-wayland
    rofi-emoji

    grim
    slurp
    wl-clipboard
    nwg-look
  ];

  # === Hyprland ===
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    extraConfig = ''
      plugin = ${hy3.packages.x86_64-linux.hy3}/lib/libhy3.so
    '';
  };

  # === Mako Config ===
  services.mako = {
    settings.default-timeout = 4000;
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