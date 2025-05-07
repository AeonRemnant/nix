export def rebuild [] {
    print "Changing directory to ~/.config/nix"
    cd ~/.config/nix

    print "Pulling git updates..."
    git pull

    print "Running nixos-rebuild..."
    sudo nixos-rebuild switch --flake ~/.config/nix#forge
}

export def upgrade [] {
    print "Switching to ~/.config/nix"
    cd ~/.config/nix

    print "Upgrading flake..."
    nix flake update
} 