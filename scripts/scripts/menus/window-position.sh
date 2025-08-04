#!/bin/bash

OPTIONS="top-left\ntop-right\nbottom-left\nbottom-right\ncenter"

# User selected option
SELECTION="$(printf "$OPTIONS" |\
fuzzel --dmenu -l 5 -p "anchor: ")"

# If the selection is empty, exit
[ -z "$SELECTION" ] && exit 1;

SIZE_SELECTION="$(cat ~/scripts/menus/data/sizes-percentage.txt|\
fuzzel --dmenu -l 5 -p "size: ")"

[ -z "$SIZE_SELECTION" ] && exit 1;

~/.config/hypr/scripts/anchor-window.sh $SELECTION $SIZE_SELECTION
