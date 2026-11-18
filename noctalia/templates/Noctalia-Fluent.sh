#!/usr/bin/env bash
PRI="{{colors.primary.default.hex}}"
C1="${PRI:1}"
THEME_NAME="Noctalia-Fluent"
THEME_DIR="$HOME/.local/share/icons/$THEME_NAME"
BASE="$HOME/.local/share/icons/.${THEME_NAME}-base"
BRANCH="color-${C1}-all-v2"

if git -C "$BASE" show-ref --quiet "refs/heads/$BRANCH"; then
    git -C "$BASE" checkout -q "$BRANCH"
else
    git -C "$BASE" checkout -q "original"
    git -C "$BASE" checkout -q -b "$BRANCH"

    find "$BASE" -type f -name "*.svg" -print0 \
        | xargs -0 -r -P "$(nproc)" sed -i \
            -e "s/#198ee6/#${C1}/gI" \
            -e "s/#363636/#${C1}/gI"

    git -C "$BASE" commit -q -am "color $BRANCH"
fi

gtk-update-icon-cache -f -t "$THEME_DIR" 2>/dev/null
CURRENT=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
if [[ "$CURRENT" == "$THEME_NAME" ]]; then
    gsettings set org.gnome.desktop.interface icon-theme "hicolor" 2>/dev/null
    sleep 0.3
    gsettings set org.gnome.desktop.interface icon-theme "$THEME_NAME" 2>/dev/null
fi
