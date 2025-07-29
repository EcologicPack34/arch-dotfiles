#!/bin/sh

negate() {
    case "$1" in
        -*) echo "${1#-}" ;;
        *)  echo "-$1" ;;
    esac
}

X="$1"
Y="$2"

hyprctl dispatch resizeactive "$X" "$Y"

moveX=$(expr $(negate "$X") / 2)
moveY=$(expr $(negate "$Y") / 2)

hyprctl dispatch moveactive "$moveX" "$moveY"
