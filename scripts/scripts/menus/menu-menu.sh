#!/bin/sh
MENUS_DIR=~/scripts/menus

SELECTION="$(ls -p "$MENUS_DIR" | grep .sh | fuzzel --dmenu -l 5)"

[ -z "$SELECTION" ] && exit 1;

sh "$MENUS_DIR/$SELECTION"
