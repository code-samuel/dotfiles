#!/bin/bash

DIR="$HOME/.config/Assets/Wallpapers"
CACHE="$HOME/.cache/current_wallpaper"
ROFI_THEME="$HOME/.config/rofi/wallpaper.rasi"
ANIME_FOLDER="$HOME/.config/Assets/Anime_icons"
ANIME_CACHE_DIR="$HOME/.cache/anime_thumbs"

if ! pgrep -x "awww-daemon" >/dev/null; then
  awww-daemon &
  sleep 0.2
fi

mapfile -d '' FILES < <(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -print0)

SELECTED=$(
  for img in "${FILES[@]}"; do
    printf "%s\x00icon\x1fthumbnail://%s\n" "${img#"$DIR"/}" "$img"
  done | rofi -dmenu -i -p "    Wallpaper" -show-icons -theme "$ROFI_THEME"
)

[ -z "$SELECTED" ] && exit 0

WALL="$DIR/$SELECTED"
echo "$WALL" >"$CACHE"

if [[ "${WALL,,}" == *.gif ]]; then
  awww img "$WALL" --transition-type none &
else
  awww img "$WALL" \
    --transition-type grow \
    --transition-duration 0.5 \
    --transition-fps 60 &
fi

(
  magick "$WALL[0]" -sample 128x128 /tmp/matugen_fast.png &&
    sleep 0.25 &&
    matugen image /tmp/matugen_fast.png --source-color-index 0 -t scheme-tonal-spot
) &

(
  SELECTED_ANIME=$(find "$ANIME_FOLDER" -type f | shuf -n 1)
  if [ -n "$SELECTED_ANIME" ]; then
    mkdir -p "$ANIME_CACHE_DIR"
    CACHED_ANIME="$ANIME_CACHE_DIR/${SELECTED_ANIME##*/}.png"

    if [ ! -f "$CACHED_ANIME" ]; then
      magick "$SELECTED_ANIME" -thumbnail 500x -define png:compression-level=1 "$CACHED_ANIME"
    fi

    ln -sf "$CACHED_ANIME" "$HOME/.config/Assets/current_anime.png"
  fi
) &
