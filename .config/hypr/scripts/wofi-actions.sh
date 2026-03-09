#!/bin/bash
cmd=$(cat $HOME/.config/hypr/hyprland/pref/actions.txt | wofi --dmenu -p Actions | awk -F'//' '{ print $2 }')
echo $cmd
eval $cmd
