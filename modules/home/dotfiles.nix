{ pkgs, flakeRoot, ... }: {

  # === Dotfile Management ===
  home.file = {
    ".config/hypr" = {
      source = flakeRoot + "/home/aeon/dotfiles/hyprland";
      recursive = true;
    };

    ".config/nushell" = {
      source = flakeRoot + "/home/aeon/dotfiles/nushell";
      recursive = true;
    };

    ".config/walker" = {
      source = flakeRoot + "/home/aeon/dotfiles/walker";
      recursive = true;
    };

    ".config/rofi" = {
      source = flakeRoot + "/home/aeon/dotfiles/rofi";
      recursive = true;
    };

    ".config/ghostty" = {
      source = flakeRoot + "/home/aeon/dotfiles/ghostty";
      recursive = true;
    };
  };


  # === Variable Management ===
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # === Cursor Management ===
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    size = 24;
    package = pkgs.bibata-cursors;

    gtk.enable = true;
    x11.enable = true;
  };
}