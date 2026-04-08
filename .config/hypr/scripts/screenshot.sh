#!/bin/bash

source "$HOME/.config/user-dirs.dirs"

lock_file="$HOME/.cache/hyprshot.lock"
output_folder="$XDG_PICTURES_DIR/screenshots"

if [[ ! -e $lock_file ]]; then
  touch $lock_file

  case $1 in
  r)
    hyprshot -z -m region -o $output_folder # region
    ;;
  w)
    hyprshot -z -m window -o $output_folder # window
    ;;
  o)
    hyprshot -z -m output -o $output_folder # monitor
    ;;
  *)
    notify-send "hyprshot failed: invalid mode: $1"
    ;;
  esac

  rm $lock_file
fi
