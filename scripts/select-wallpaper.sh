#!/bin/bash

DIR="$HOME/.config/Assets/Wallpapers"
CACHE="$HOME/.cache/current_wallpaper"
ROFI_THEME="$HOME/.config/rofi/wallpaper.rasi"
ANIME_FOLDER="$HOME/.config/Assets/Anime_icons"

if ! pgrep -x "awww-daemon" >/dev/null; then
  awww-daemon &
  sleep 0.2
fi

mapfile -d '' FILES < <(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -print0)

SELECTED=$(
  for img in "${FILES[@]}"; do
    name=$(basename "$img")
    printf "%s\x00icon\x1fthumbnail://%s\n" "$name" "$img"
  done | rofi -dmenu -i -p "    Wallpaper" -show-icons -theme "$ROFI_THEME"
)

[ -z "$SELECTED" ] && exit 0

WALL="$DIR/$SELECTED"
echo "$WALL" >"$CACHE"

# 4. Aplicação Inteligente
if [[ "${WALL,,}" == *.gif ]]; then
  awww img "$WALL" --transition-type none
else
  awww img "$WALL" \
    --transition-type grow \
    --transition-duration 1 \
    --transition-fps 60
fi
matugen image "$WALL" --source-color-index 0 -t scheme-tonal-spot

ln -sf "$(find "$ANIME_FOLDER" -type f | shuf -n 1)" "$HOME/.config/Assets/current_anime.png"
