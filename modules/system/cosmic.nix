{ config, pkgs, inputs, ... }:

{
  # === Imports ===
  imports = [

    # Cosmic
    cosmic-launcher
    cosmic-session
    cosmic-greeter
  ];
}