{ config, pkgs, inputs, lib, username, ... }:

{
  home.packages = with pkgs; [

    # === Terminal + Shell ===
    ghostty
    nushell
    nushellPlugins.highlight

    # === Tools ===
    neofetch
    helix
    git-credential-manager
    nix-search-cli
    docker
    terraform
    kubectl
    talosctl
    omnictl

    # === Programming ===
    go
    flutter

    # === Apps ===
    inputs.zen-browser.packages."${pkgs.system}".default
    spacedrive
    vesktop
    plex-desktop
    vscode
    deluge
    pwvucontrol

    # === Ricing ===
    bibata-cursors
  ];

  services.flatpak.packages = [
    "app.freelens.Freelens"
    "com.mastermindzh.tidal-hifi"
  ];

  # === Programs ===
  programs.git = {
    enable = true;
    userName = "AeonRemnant";
    userEmail = "aeonremnant@github.com";
    extraConfig = {
      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
    };
  };
}