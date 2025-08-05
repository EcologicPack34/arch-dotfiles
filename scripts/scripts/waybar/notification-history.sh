count_history=$(dunstctl count history)
count_displayed=$(dunstctl count displayed)

if [[ $count_displayed > 0 ]]; then
	dunstctl close-all
else
	for ((i=1; i<=count_history; i++)); do
	    dunstctl history-pop
	done
fi
