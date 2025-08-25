alias hyprconf='sudo nano ~/.config/hypr/hyprland.conf'
alias bashreload='source ~/.bashrc'
alias please='sudo '
alias kys='systemctl poweroff '
alias NOW=''
alias restart='systemctl reboot '
alias supertree='tree -C -I .git -a'
alias dotfiles='cd ~/dotfiles'
alias rm='rm -I'
alias vpn-connect='sudo wg-quick up'
alias vpn-disconnect='sudo wg-quick down'
alias vpn-status='sudo wg'
alias vpn-list='sudo ls /etc/wireguard'

function waifu() {
	local FILE="$(~/scripts/waifu/waifu.sh "$@")" || return
	kitty icat "$FILE"
}

function daily_waifu() {
	local POSSIBLE_TYPES="sfw waifu\nsfw neko\nsfw shinobu\nsfw megumin"
	local PROGRAM=("${1:-kitty}") # Use array for programs with args
	[ "${PROGRAM[0]}" = "kitty" ] && local PROGRAM=(kitty icat)
	
	local WAIFU_FILE="$(~/scripts/waifu/daily-waifu.sh $(printf "$POSSIBLE_TYPES" | shuf -n1))" || return
	"${PROGRAM[@]}" "$WAIFU_FILE"
}

function save_waifu() {
	local OUTPUT="$(xdg-user-dir PICTURES)/.waifus"
	mkdir -p "$OUTPUT"

	local TYPE="${1:-normal}"

	case "$TYPE" in
		"normal")
			local FILE="/tmp/waifu";;
		"daily")
			local FILE="$(~/scripts/waifu/daily-waifu.sh)" || return;;
	esac

	[ -f "$FILE" ] || {
		echo "$FILE not found" >&2
		return
	}

	local CATEGORY="$(getfattr -n user.category "$FILE" --absolute-names --only-values)"
	local TIMESTAMP="$(stat -c %Y "$FILE")"
	local FINAL_FILE="$OUTPUT"/"$CATEGORY"_"$TIMESTAMP"
	cp "$FILE" "$FINAL_FILE"
	echo "$FINAL_FILE"
}	



