#!/bin/bash

cache="$HOME/.cache/current-wallpaper"

hyprctl hyprpaper wallpaper ",$1"
# to be used later
ln -sf "$1" "$cache"
