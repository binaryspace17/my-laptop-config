#!/bin/sh
wp="$NOCTALIA_WALLPAPER_PATH"

case "$(printf %s "$wp" | tr 'A-Z' 'a-z')" in
  */pictures/wallpapers/light/thatch/*) scheme="Thatch" ;;
  */pictures/wallpapers/dark/monium/*) scheme="Monium" ;;
  */pictures/wallpapers/light/cairn/*)  scheme="Cairn"  ;;
  */pictures/wallpapers/light/brume/*)  scheme="Brume"  ;;
  */pictures/wallpapers/light/ash/*)    scheme="Ash"    ;;
  *) exit 0 ;;
esac

if [ "$(noctalia msg color-scheme-get)" != "custom $scheme" ]; then
  noctalia msg color-scheme-set custom "$scheme"
fi

~/.local/bin/fix-micro.sh
