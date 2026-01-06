#!/bin/bash

walls_dir="$HOME/pics/wallpapers"
cache="$HOME/.cache/current-wallpaper"
hyprpaper_conf="$HOME/.config/hypr/hyprpaper.conf"

wall=$(ls "$walls_dir" -1 | wofi --dmenu)

if [[ -n $wall ]]; then
  hyprctl hyprpaper preload "$walls_dir/${wall}"
  hyprctl hyprpaper wallpaper ",$walls_dir/${wall}"

  # to be used later
  ln -sf "$walls_dir/$wall" "$cache"
EOF
fi
