set -g __fish_git_prompt_showdirtystate
set -g __fish_git_prompt_showcolorhints
set -g __fish_git_prompt_showupstream
set -g __fish_git_prompt_char_dirtystate '±'
set -g __fish_git_prompt_char_cleanstate ''
set -g __fish_git_prompt_char_upstream_ahead '↑'
set -g __fish_git_prompt_char_upstream_behind '↓'
set -g __fish_git_prompt_char_upstream_diverged '↕'

function fish_prompt
	echo -n -s (set_color --bold blue) (prompt_pwd) (set_color white) (__fish_git_prompt) (set_color --bold yellow) " » " (set_color normal)
end
