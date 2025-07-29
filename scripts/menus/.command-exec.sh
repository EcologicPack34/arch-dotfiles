#!/bin/bash
CMD="$(fuzzel --dmenu -l 0)"
PREFIX="uwsm app --"

[ -z "$CMD" ] && exit 1;
[ "$CMD" == "foxy" ] && CMD="firefox --profile ~/.mozilla/firefox/bgzxop9w.foxy/"

ERROR_MSG=$(sh -c "$PREFIX $CMD" 2>&1) || {
	notify-send "ERROR" "$ERROR_MSG" -u CRITICAL
}
