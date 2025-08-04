#!/bin/bash

SELECTION="$(cat ~/scripts/menus/data/sizes-percentage.txt|\
fuzzel --dmenu -l 5 -p "size: ")"

[ -z "$SELECTION" ] && exit 1;

hyprctl dispatch resizeactive exact $SELECTION $SELECTION
echo $SELECTION
