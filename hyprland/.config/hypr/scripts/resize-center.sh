#!/bin/sh

negate() {
    case "$1" in
        -*) echo "${1#-}" ;;
        *)  echo "-$1" ;;
    esac
}

x="$1"
y="$2"

hyprctl dispatch resizeactive "$x" "$y"

moveX=$(expr $(negate "$x") / 2)
moveY=$(expr $(negate "$y") / 2)

hyprctl dispatch moveactive "$moveX" "$moveY"
