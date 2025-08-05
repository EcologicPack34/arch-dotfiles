#!/bin/bash

PROFILE_PATHS="$(cat $(xdg-user-dir DOCUMENTS)/.firefox-profiles)"

[ -z "$PROFILE_PATHS" ] && exit 1;

LINES="$(echo "$PROFILE_PATHS" | wc -l)"
SELECTION="$(echo "$PROFILE_PATHS" | awk -F/ '{print $NF}' |\
fuzzel --dmenu -l $LINES)"

[ -z "$SELECTION" ] && exit 1;

FULL_PATH="$(echo "$PROFILE_PATHS" | grep "$SELECTION")"

uwsm app -- firefox --profile "$FULL_PATH"
