#!/bin/bash

cache_file="$HOME/.cache/hypr-zen-mode"

set() {
  hyprctl keyword decoration:rounding 0
  hyprctl keyword decoration:rounding_power 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:border_size 1

  echo "yes" > $cache_file
}

reset() {
  hyprctl reload

  echo "no" > $cache_file
}

case "$1" in
s)
  set
  ;;
r)
  reset
  ;;
t)
  if [[ $(grep "yes" "$cache_file") ]]; then
    reset
  else
    set
  fi

  ;;
*)
  echo "$0: Invalid param. Usage: $0 [s|r|t]"
  ;;
esac
