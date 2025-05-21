function rebuild
    echo "Changing directory to ~/.config/nix"
    cd ~/.config/nix

    echo "Pulling git updates..."
    git pull

    echo "Running nixos-rebuild..."
    sudo nixos-rebuild switch --flake ~/.config/nix#forge
end