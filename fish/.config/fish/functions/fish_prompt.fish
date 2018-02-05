function fish_prompt
	echo -n -s (set_color --bold blue) (prompt_pwd) (set_color --bold yellow) " » " (set_color normal)
end
