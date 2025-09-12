#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\033[0;32m\u\033[0m@\033[0;36m\h \033[0;33m\W\033[0m]\$ '
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='[\[\e[38;5;46m\]\u\[\e[0m\]@\[\e[38;5;51m\]\H\[\e[0m\](\[\e[38;5;220m\]\W\[\e[0m\])\[\e[1;3m\]${PS1_CMD1}\[\e[0m\]]\\$ '

alias hyprconfig='nano ~/.config/hypr/hyprland.conf'

alias poff='systemctl poweroff'
alias repoff='systemctl reboot'


export GRUB_MODULES="all_video boot cat chain configfile echo efifwsetup efinet ext2 fat font gettext gfxmenu gfxterm gfxterm_background gzio halt help iso9660 jpeg keystatus loadenv loopback linux ls lsefi lsefimmap lsefisystab lssal minicmd normal ntfs part_msdos part_gpt png probe reboot regexp search search_fs_uuid search_fs_file search_label true video tpm"
