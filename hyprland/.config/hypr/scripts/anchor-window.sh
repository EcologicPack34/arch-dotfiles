#!/bin/bash

ANCHOR="$1"
SIZE="$2"
HORIZONTAL_GAP="${3:-1}"
VERTICAL_GAP="${4:-5}"

# Used for calculating the right and bottom percentages
SIZE_NUM="${SIZE%\%}"

if [ -z "$ANCHOR" ]; then
	echo "No anchor specified"
	exit 1
fi

if [ -z "$SIZE" ]; then
	echo "No size specified"
	exit 1
fi

hyprctl dispatch setfloating
hyprctl dispatch resizeactive exact $SIZE $SIZE

case $ANCHOR in
	*"top-left")
		X="$HORIZONTAL_GAP"%
		Y="$VERTICAL_GAP"%
		;;
	*"top-right")
		X="$((100-$SIZE_NUM-$HORIZONTAL_GAP))%"
		Y="$VERTICAL_GAP"%
		;;
	*"bottom-left")
		X="$HORIZONTAL_GAP"%
		Y="$((100-$SIZE_NUM-$VERTICAL_GAP))%"
		;;
	*"bottom-right")
		X="$((100-$SIZE_NUM-$HORIZONTAL_GAP))%"
		Y="$((100-$SIZE_NUM-$VERTICAL_GAP))%"
		;;
	*"center")
		hyprctl dispatch centerwindow;;
esac


[ -z "$X" ] && exit 0;
[ -z "$Y" ] && exit 0;

hyprctl dispatch moveactive exact "$X" "$Y"
