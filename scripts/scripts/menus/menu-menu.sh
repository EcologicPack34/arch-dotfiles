#!/bin/sh
MENUS_DIR=~/scripts/menus

SELECTION="$(ls "$MENUS_DIR" | fuzzel --dmenu -l 5)"

[ -z "$SELECTION" ] && exit 1;

sh "$MENUS_DIR/$SELECTION"
