{ pkgs, inputs, ... }: 

{
  home.packages = with pkgs; [

    # === Terminal + Shell ===
    ghostty
    fish

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
    libsecret

    # === Programming ===
    go
    nixd
    nixdoc
    colmena
    deadnix
    nodejs_24
    python314

    # === Apps ===
    inputs.zen-browser.packages."${pkgs.system}".default
    vesktop
    goofcord
    plex-desktop
    vscode
    deluge
    pwvucontrol
    woeusb
    gale
    prismlauncher
    zed-editor
    windsurf
    pinta
    kdePackages.ark
    firejail
    signal-desktop-bin
    simplex-chat-desktop
    adoptopenjdk-icedtea-web

    # Wine
    wine64Packages.unstable
    winetricks
    protontricks
    mono
    bottles

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
      credential.credentialStore = "secretservice";
    };
  };
}
