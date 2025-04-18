# Updates Nix config git and rebuilds.
export def rebuild [] {
    print "Changing directory to ~/.config/nix"
    cd ~/.config/nix

    print "Pulling git updates..."
    git pull

    print "Running nixos-rebuild..."
    sudo nixos-rebuild switch --flake ~/.config/nix#forge
}