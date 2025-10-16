alias hyprconf='cd ~/.config/hypr/conf'
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
alias test-keys='wev'
alias diff='diff --color'

# Temp for testing with the damn hdmi port
function check_hdmi() {
	hdmi_id="$(wpctl status | grep "DisplayPort 1" | sed 's/\..*//' | grep -oE '[0-9]+')"
	wpctl inspect "$hdmi_id"
}

function waifu() {
	local file="$(~/scripts/waifu/waifu.sh "$@")" || return
	kitty icat "$file"
}

function daily_waifu() {
	local possible_types="sfw waifu\nsfw neko\nsfw shinobu\nsfw megumin"
	local program=("${1:-kitty}") # Use array for programs with args
	[ "${program[0]}" = "kitty" ] && local program=(kitty icat)
	
	local waifu_file="$(~/scripts/waifu/daily-waifu.sh $(printf "$possible_types" | shuf -n1))" || return
	"${program[@]}" "$waifu_file"
}

function save_waifu() {
	local output="$(xdg-user-dir PICTURES)/.waifus"
	mkdir -p "$output"

	local type="${1:-normal}"

	case "$type" in
		"normal")
			local file="/tmp/waifu";;
		"daily")
			local file="$(~/scripts/waifu/daily-waifu.sh)" || return;;
	esac

	[ -f "$file" ] || {
		echo "$file not found" >&2
		return
	}

	local category="$(getfattr -n user.category "$file" --absolute-names --only-values)"
	local timestamp="$(stat -c %Y "$file")"
	local final_file="$output"/"$category"_"$timestamp"
	cp "$file" "$final_file"
	echo "$final_file"
}	



