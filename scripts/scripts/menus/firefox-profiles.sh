#!/bin/bash

profile_paths="$(cat $(xdg-user-dir DOCUMENTS)/.firefox-profiles)"

[ -z "$profile_paths" ] && exit 1;

options="$(echo "$profile_paths" | grep -v "#\
" | awk -F/ '{print $NF}')"
lines="$(echo "$options" | wc -l)"
selection="$(echo "$options" |\
fuzzel --dmenu -l $lines)"

[ -z "$selection" ] && exit 1;

full_path="$(echo "$profile_paths" | grep "$selection")"

uwsm app -- firefox --profile "${full_path//#}"
