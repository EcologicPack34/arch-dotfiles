#!/bin/bash

anchor="$1"
size="$2"
horizontal_gap="${3:-1}"
vertical_gap="${4:-5}"


if [ -z "$anchor" ]; then
	echo "No anchor specified"
	exit 1
fi

if [ -z "$size" ]; then
	echo "No size specified"
	exit 1
fi

hyprctl dispatch setfloating
hyprctl dispatch resizeactive exact $size $size

# Used for calculating the right and bottom percentages
size_num="${size%\%}"

case $anchor in
	*"top-left")
		x="$horizontal_gap"%
		y="$vertical_gap"%
		;;
	*"top-right")
		x="$((100-$size_num-$horizontal_gap))%"
		y="$vertical_gap"%
		;;
	*"bottom-left")
		x="$horizontal_gap"%
		y="$((100-$size_num-$vertical_gap))%"
		;;
	*"bottom-right")
		x="$((100-$size_num-$horizontal_gap))%"
		y="$((100-$size_num-$vertical_gap))%"
		;;
	*"center")
		hyprctl dispatch centerwindow;;
esac


[ -z "$x" ] && exit 0;
[ -z "$y" ] && exit 0;

hyprctl dispatch moveactive exact "$x" "$y"
