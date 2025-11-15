#!/bin/sh
menus_dir=~/scripts/menus

selection="$(ls -p "$menus_dir" | grep .sh | fuzzel --dmenu -l 5)"

[ -z "$selection" ] && exit 1;

sh "$menus_dir/$selection"
