{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gamemode

    # Modloaders
    r2modman
  ];

  # === Gamemode === 
  programs.gamemode.enable = true;
}
