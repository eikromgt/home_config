#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f "${HOME}/.bash_aliases" ]] && source "${HOME}/.bash_aliases"

export PATH="$PATH:$HOME/.local/bin"
export ZSH="$HOME/.local/share/oh-my-zsh"

HISTSIZE=200000
SAVEHIST=200000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

ZSH_THEME="kolo"
#PROMPT='%B%F{magenta}%c%f%b %# '
ZSH_THEME_GIT_PROMPT_CACHE=1

CASE_SENSITIVE="true"

alias lg="lazygit"

eval "$(direnv hook zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

plugins=(sudo zsh-autosuggestions zsh-syntax-highlighting zsh-output-highlighting colored-man-pages
    aliases alias-finder git gh archlinux docker history kitty rsync ssh
    copypath cp fzf)

source $ZSH/oh-my-zsh.sh
