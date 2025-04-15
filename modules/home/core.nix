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
    gource
    xfce.thunar-archive-plugin
    xfce.thunar-volman

    # === Programming ===
    go
    flutter
    nixd
    nixdoc

    # === Apps ===
    inputs.zen-browser.packages."${pkgs.system}".default
    vesktop
    plex-desktop
    vscode
    deluge
    pwvucontrol
    woeusb
    gale
    prismlauncher
    zed-editor
    pinta

    # === Ricing ===
    bibata-cursors
  ];

  services.flatpak.packages = [
    "app.freelens.Freelens"
    "com.mastermindzh.tidal-hifi"
  ];

  # === Programs ===

  # Git config
  programs.git = {
    enable = true;
    userName = "AeonRemnant";
    userEmail = "aeonremnant@github.com";
    extraConfig = {
      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
    };
  };
}
