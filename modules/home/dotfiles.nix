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


  # === Variable Management ===
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}