# NixOS rebuild
export def rebuild [] {
    print "Changing directory to ~/.config/nix"
    cd ~/.config/nix

    print "Fetching git updates..."
    git fetch

    print "Running nixos-rebuild..."
    sudo nixos-rebuild switch --flake ~/.config/nix#forge
}