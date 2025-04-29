let current_tty = (tty | str trim)

if $current_tty == "/dev/tty1" {
    exec Hyprland
} else {
}