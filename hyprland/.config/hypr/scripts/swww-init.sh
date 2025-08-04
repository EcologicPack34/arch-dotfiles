#!/usr/bin/env bash

swww-daemon --no-cache &

sleep 0.1
if ! swww query &> /dev/null; then
	echo "FAILED TO LOAD SWWW"
	exit 1
fi
swww clear
swww img $1
