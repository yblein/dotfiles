#
# Aliases
#

alias ls='ls --color=auto -F'
alias grep='grep --color=auto'
alias diff='colordiff'

alias l='ls -lh'
alias ll='l -A'

alias v='vim'
alias vi='vim'
alias sv='sudo vim'

alias pac='pacaur'

alias k='killall'
alias c='cat'
alias z='zathura'
alias g='git'
alias m='make'
alias x='sxiv'

alias rr='rm -r'
alias t='st&'

alias path='echo -e ${PATH//:/\\n}'
alias sheep="mpv --no-video --ytdl-format=bestaudio 'http://www.youtube.com/playlist?list=PLDfKAXSi6kUakvzXfiA0DdSl-OzBi2fVt' --shuffle"

#
# Functions
#

function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
function bak () { cp -a "$1" "${1}_$(date --iso-8601=seconds)" }
function sdm() { udisksctl mount -b "/dev/sd$1" }
function sdu() { udisksctl unmount -b "/dev/sd$1" }
function y() {
	pacaur -S $(pacaur --color=always -Ss $@ | sed '$!N;s/\n    / /' | fzf --ansi -m | cut -d " " -f 1)
}
function mktgz() { tar czf "$1.tar.gz" "$1" }

#
# Colors
#

autoload -Uz colors
colors
eval $(dircolors)

#
# Prompt
#

#PROMPT="%{$bold_color%}%{$fg[red]%}%(?..[%?]) %{$fg[blue]%}%30<..<%~%{$fg[yellow]%} %(!.#.>)%{$reset_color%} "
SPROMPT="zsh: correct '$fg[red]%R$reset_color' to '$fg[green]%r$reset_color' [nyae]? "

function zle-line-init zle-keymap-select {
	local current_pwd="${PWD/#$HOME/~}"
	local short_pwd

	if [[ "$current_pwd" == (#m)[/~] ]]; then
		short_pwd="$MATCH"
		unset MATCH
	else
		short_pwd="${${${${(@j:/:M)${(@s:/:)current_pwd}##.#?}:h}%/}//\%/%%}/${${current_pwd:t}//\%/%%}"
	fi

	local symbol=${${KEYMAP/vicmd/<}/(main|viins)/>}

	PROMPT="%{$bold_color%}%{$fg[red]%}%(?..[%?]) %{$fg[blue]%}$short_pwd %{$fg[yellow]%}%(!.#.$symbol)%{$reset_color%} "
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#
# History
#

HISTFILE="$HOME/.history"
HISTSIZE=8192
SAVEHIST=8192
setopt extended_history # save start time and duration
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history # write history incrementally
setopt share_history

#
# Editor
#

autoload -Uz edit-command-line
zle -N edit-command-line

KEYTIMEOUT=1 # faster vim mode switch

bindkey -v
# edit command line
bindkey -M vicmd 'q' edit-command-line
# vimrc-like
bindkey -M vicmd 'H' vi-beginning-of-line
bindkey -M vicmd 'L' vi-end-of-line
# Beginning search with up and down
bindkey -M vicmd "k" up-line-or-search
bindkey -M vicmd "j" down-line-or-search
# vim-like completion
bindkey "^p" up-line-or-search
bindkey "^n" down-line-or-search
# backward search
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
# arrows
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[C' forward-char
# del
bindkey -M viins '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char

# Auto ls on empty line
auto-ls () {
    if [[ $#BUFFER -eq 0 ]]; then
        print
        ls
        zle redisplay
    else
        zle .$WIDGET
    fi
}
zle -N accept-line auto-ls
zle -N other-widget auto-ls

#
# Utility
#

REPORTTIME=1
setopt notify
setopt no_hup
setopt no_check_jobs
setopt no_beep
setopt numeric_glob_sort
setopt auto_cd
setopt auto_pushd
setopt correct

#
# Terminal title
#

precmd () { print -Pn "\e]0;%~ %(!.#.>)\a" }
preexec () { print -Pn "\e]0;%~ %(!.#.>) $1\a" }

#
# Syntax highlighting
#

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2> /dev/null

#
# Extra modules
#

# autoload -Uz zmv
# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

#
# Completion
#
# Mostly taken from prezto (https://github.com/sorin-ionescu/prezto)
#

autoload -Uz compinit
compinit -i

setopt complete_in_word    # Complete from both ends of a word.
setopt always_to_end       # Move cursor to the end of a completed word.
setopt auto_list no_list_ambiguous # Automatically list choices on ambiguous completion.
setopt auto_param_slash    # If completed parameter is a directory, add a trailing slash.
setopt extended_glob       # Needed for file modification glob modifiers with compinit
setopt no_flow_control     # Disable start/stop characters in shell

# Completion caching
zstyle ':completion:*' use-cache  yes
zstyle ':completion:*:complete:*' cache-path "$HOME/.cache/zsh"

# Case-insensitive (all), partial-word, and then substring completion.
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word. But make
# sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Populate hostname completion. But allow ignoring custom entries from static
# */etc/hosts* which might be uninteresting.
zstyle -a ':prezto:module:completion:*:hosts' etc-host-ignores '_etc_host_ignores'

zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Ignore multiple entries.
#zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
#zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Mutt
if [[ -s "$HOME/.mutt/aliases" ]]; then
  zstyle ':completion:*:*:mutt:*' menu yes select
  zstyle ':completion:*:mutt:*' users ${${${(f)"$(<"$HOME/.mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
fi

# SSH/SCP/RSYNC
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Provide more processes in completion of programs like killall
zstyle ':completion:*:processes'       command 'ps -a -u $USER'
zstyle ':completion:*:processes-names' command 'ps c -u $USER -o command'

# Custom completions
fpath+=~/.zfunc
