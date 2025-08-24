#!/bin/bash

options="center\ntop-left\ntop-right\nbottom-left\nbottom-right"

# User selected option
selection="$(printf "$options" |\
fuzzel --dmenu -l 5 -p "anchor: ")"

# If the selection is empty, exit
[ -z "$selection" ] && exit 1;

size_selection="$(cat ~/scripts/data/sizes-percentage.txt|\
fuzzel --dmenu -l 5 -p "size: ")"

[ -z "$size_selection" ] && exit 1;

# The quotes around size_selection is an ugly workaround
# to allow resizing on both dimensions independently
~/.config/hypr/scripts/anchor-window.sh $selection "$size_selection"
