#!/bin/bash

TODO_FILE="$(xdg-user-dir DOCUMENTS)/todo.txt"

[ -f "$TODO_FILE" ] || touch "$TODO_FILE";

while true; do
	ITEMS="$(cat "$TODO_FILE")"
	COUNT="$(echo "$ITEMS" | wc -l)"

	[ -z "$ITEMS" ] && COUNT=0;

	WIDTH="$(awk -v extra=6 -v min=50 -v cap=100 '{ if (length > max) max = length } END { m = max + extra; if (m > cap) m = cap; if (m < min) m = min; print m }' <<< "$ITEMS")"
		

	SELECTION="$(echo "$ITEMS" | fuzzel --dmenu -w "$WIDTH" -l "$COUNT" -p "// ")"

	[ -z "$SELECTION" ] && exit 1;

	# Fx matches the entire line for the exact string
	if grep -Fxq "$SELECTION" <<< "$ITEMS"; then
		grep -Fxv "$SELECTION" <<< "$ITEMS" > "$TODO_FILE"
	else
		echo "$SELECTION" >> "$TODO_FILE"
	fi
done
