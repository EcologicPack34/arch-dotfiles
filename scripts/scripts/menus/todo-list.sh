#!/bin/bash

TODO_FILE="$(xdg-user-dir DOCUMENTS)/todo.txt"

[ -f "$TODO_FILE" ] || touch "$TODO_FILE";

while true; do
	ITEMS="$(cat "$TODO_FILE")"
	COUNT="$(echo "$ITEMS" | wc -l)"

	[ -z "$ITEMS" ] && COUNT=0;

	SELECTION="$(echo "$ITEMS" | fuzzel --dmenu -w "50" -l "$COUNT" -p "// ")"

	[ -z "$SELECTION" ] && exit 1;

	# Fx matches the entire line for the exact string
	if grep -Fxq "$SELECTION" <<< "$ITEMS"; then
		grep -Fxv "$SELECTION" <<< "$ITEMS" > "$TODO_FILE"
	else
		echo "$SELECTION" >> "$TODO_FILE"
	fi
done
