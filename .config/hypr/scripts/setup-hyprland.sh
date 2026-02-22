#!/bin/bash

dir=$HOME/.config/hypr/hyprland/pref/

if [[ ! -d $dir ]]; then
  mkdir $dir

  touch $dir/rules.conf
  touch $dir/actions.txt
  cat <<EOF > $dir/actions.txt
Toggle Bar // qs ipc call bar toggle
Toggle Wallpaper Panel // qs ipc call wallPanel toggle
Toggle DND // makoctl mode -t dnd; notify-send "DND OFF" "You're seeing because DND is now OFF."
EOF
fi
