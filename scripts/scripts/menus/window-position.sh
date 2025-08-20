#!/bin/bash

OPTIONS="center\ntop-left\ntop-right\nbottom-left\nbottom-right"

# User selected option
SELECTION="$(printf "$OPTIONS" |\
fuzzel --dmenu -l 5 -p "anchor: ")"

# If the selection is empty, exit
[ -z "$SELECTION" ] && exit 1;

SIZE_SELECTION="$(cat ~/scripts/data/sizes-percentage.txt|\
fuzzel --dmenu -l 5 -p "size: ")"

[ -z "$SIZE_SELECTION" ] && exit 1;

# The quotes around size_selection is an ugly workaround
# to allow resizing on both dimensions independently
~/.config/hypr/scripts/anchor-window.sh $SELECTION "$SIZE_SELECTION"
