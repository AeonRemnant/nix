{ config, pkgs, inputs, username, ... }: {

  # === Dotfile Management ===
  home.file = {
    ".config/hypr" = {
      source = ./dotfiles/hyprland;
      recursive = true;
    };

    ".config/nushell" = {
      source = ./dotfiles/nushell;
      recursive = true;
    };

    ".config/walker" = {
      source = ./dotfiles/walker;
      recursive = true;
    };
  };
}