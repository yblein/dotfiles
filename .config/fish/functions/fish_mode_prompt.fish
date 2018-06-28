# The fish_mode_prompt function is prepended to the prompt
function fish_mode_prompt --description "Displays the current mode"
	echo -n '['
	switch $fish_bind_mode
		case default
			set_color blue
			echo 'n'
		case insert
			set_color green
			echo 'i'
		case replace_one
			set_color cyan
			echo 'r'
		case visual
			set_color magenta
			echo 'v'
	end
	set_color normal
	echo -n '] '
end
