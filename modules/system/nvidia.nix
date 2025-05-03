{ config, pkgs, lib, ... }:

{
  # === Global Config ===
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # === Nvidia Driver Config ===
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      # Options: latest, stable, beta.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    
    # === Compatibility ===
    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
    };
  };
} 