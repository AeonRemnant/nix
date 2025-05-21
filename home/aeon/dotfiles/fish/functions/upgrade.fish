function upgrade
    echo "Switching to ~/.config/nix"
    cd ~/.config/nix

    echo "Upgrading flake..."
    nix flake update
end