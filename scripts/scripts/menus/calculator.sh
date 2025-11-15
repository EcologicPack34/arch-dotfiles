#!/usr/bin/env sh

# Define the variable that holds the last result
last=""

# Don't stop until the user hits escape or clicks off of fuzzel
while true; do
	# Add a space on the first run
	[ -z "$last" ] && space=" "
	# Get user input
	next="$(fuzzel -l 0 --dmenu -p "${last}${space}")"
	# Quit if empty
	[ -z "$next" ] && exit 1
	# Copy and exit if y is entered
	[ "$next" = "y" ] && wl-copy "$last" && exit 0
	# Pipe the expression into bc and strip off trailing zeroes
	last="$(echo "$last$next" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')"
done
