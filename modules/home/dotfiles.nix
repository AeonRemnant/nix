{ config, pkgs, inputs, username, ... }: {

  # === Dotfile Management ===
  home.file = {
    ".config/hypr" = {
      source = ../../../home/aeon/dotfiles/hyprland;
      recursive = true;
    };

    ".config/nushell" = {
      source = ../../../home/aeon/dotfiles/nushell;
      recursive = true;
    };

    ".config/walker" = {
      source = ../../../home/aeon/dotfiles/walker;
      recursive = true;
    };
  };


  # === Variable Management ===
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}