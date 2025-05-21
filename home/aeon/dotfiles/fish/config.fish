# === Keychain ===
if type -q keychain
    keychain --eval --quiet ~/.ssh/forge | source
end

# === Launch Hyprland ===
set current_tty (tty | string trim)
if test "$current_tty" = "/dev/tty1"
    exec Hyprland
end

# === Greeting ===
set -g fish_greeting "Welcome, $USER!"

# === Aliases ===
alias ls='ls --color=auto'
alias ll='ls -lh'

# === NixOS Environment Variables ===
fish_add_path "$HOME/.nix-profile/bin"