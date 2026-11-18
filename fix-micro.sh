#!/bin/sh
# wait for Noctalia to finish writing its files
sleep 2
sed -i -E 's|"colorscheme": *"[^"]*"|"colorscheme": "fix"|' ~/.config/micro/settings.json
