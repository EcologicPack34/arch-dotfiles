#!/bin/bash

PROFILE_PATHS="$(cat $(xdg-user-dir DOCUMENTS)/.firefox-profiles)"

[ -z "$PROFILE_PATHS" ] && exit 1;

OPTIONS="$(echo "$PROFILE_PATHS" | grep -v "#\
" | awk -F/ '{print $NF}')"
LINES="$(echo "$OPTIONS" | wc -l)"
SELECTION="$(echo "$OPTIONS" |\
fuzzel --dmenu -l $LINES)"

[ -z "$SELECTION" ] && exit 1;

FULL_PATH="$(echo "$PROFILE_PATHS" | grep "$SELECTION")"

uwsm app -- firefox --profile "${FULL_PATH//#}"
