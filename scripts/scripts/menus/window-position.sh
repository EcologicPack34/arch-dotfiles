#!/bin/bash

OPTIONS="top-left\ntop-right\nbottom-left\nbottom-right\ncenter"

# User selected option
SELECTION="$(printf "$OPTIONS" |\
fuzzel --dmenu -l 5)"

# If the selection is empty, exit
[ -z "$SELECTION" ] && exit 1;

SIZE_OPTIONS="50%%\n40%%\n30%%\n20%%\n10%%\n60%%\n70%%\n80%%\n90%%\n100%%"

# Get the size selection (30% for default)
SIZE_SELECTION="$(printf "$SIZE_OPTIONS"|\
fuzzel --dmenu -l 5)"

[ -z "$SIZE_SELECTION" ] && exit 1;

~/.config/hypr/scripts/anchor-window.sh $SELECTION $SIZE_SELECTION
