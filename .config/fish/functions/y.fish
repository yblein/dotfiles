function y
	pacaur -S (pacaur --color=always -Ss $argv | sed '$!N;s/\n    / /' | fzf --ansi -m | cut -d " " -f 1)
end
