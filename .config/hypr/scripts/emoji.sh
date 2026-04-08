# custom mode for rofi

[ -z "${ROFI_OUTSIDE}" ] && echo "run this script in rofi" && exit

if [[ ! "$@" ]]; then
  emoji_list=$(cat $HOME/.config/hypr/data/emoji-list.txt)
  echo "$emoji_list"
else
  echo "$1" | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
fi
