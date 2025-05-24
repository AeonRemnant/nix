# === Autoboot Apps ===

# DP-1
hyprctl dispatch workspace 1 silent
sleep 0.5
hyprctl dispatch exec code
sleep 1

# DP-2
hyprctl dispatch workspace 6 silent
sleep 0.5
hyprctl dispatch exec com.mastermindzh.tidal-hifi
sleep 0.2
hyprctl dispatch exec goofcord
sleep 1

# DP-1
hyprctl dispatch workspace 2 silent
sleep 0.5
hyprctl dispatch exec steam