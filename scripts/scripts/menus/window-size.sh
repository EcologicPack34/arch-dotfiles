#!/bin/bash

selection="$(cat ~/scripts/data/sizes-percentage.txt|\
fuzzel --dmenu -l 5 -p "size: ")"

[ -z "$selection" ] && exit 1;

hyprctl dispatch resizeactive exact $selection $selection
echo $selection
