# custom mode for rofi

[ -z "${ROFI_OUTSIDE}" ] && echo "run this script in rofi" && exit

if [[ "$#" -eq 0 ]]; then
  actions=$(cat "$HOME/.config/hypr/hyprland/pref/actions.txt")
  echo "$actions"
  exit 0
fi

cmd=$(echo "$1" | awk -F'=>' '{ print $2 }')

if [[ -n "$cmd" ]]; then
  sh -c -- "$cmd" &>/dev/null &
  disown
fi
