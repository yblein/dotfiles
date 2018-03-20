# Start X if log in tty1
if (( UID )); then
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi
