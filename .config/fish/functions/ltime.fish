function ltime --description 'Print last command duration in seconds'
	echo (math --scale=3 $CMD_DURATION / 1000)"s"
end
