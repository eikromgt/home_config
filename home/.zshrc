#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f "${HOME}/.bash_aliases" ]] && source "${HOME}/.bash_aliases" 

function update_vpn() {
    wget -U "Mozilla/6.0" -O ~/.cache/config.yaml.download https://w2.v2free.top/link/S1D4520lMEWddwY5\?clash\=2\&rate\=false
    if [[ $? == 0 ]]; then
        cp ~/.cache/config.yaml.download ~/.config/mihomo/config.yaml
    fi
}

export PATH="$PATH:$HOME/.local/bin"
export ZSH="$HOME/.local/share/oh-my-zsh"
export HISTSIZE=50000
export SAVEHIST=100000

ZSH_THEME="kolo"
#PROMPT='%B%F{magenta}%c%f%b %# '
ZSH_THEME_GIT_PROMPT_CACHE=1

CASE_SENSITIVE="true"

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default


plugins=(sudo zsh-autosuggestions zsh-syntax-highlighting zsh-output-highlighting colored-man-pages
    aliases alias-finder git gh archlinux docker history kitty rsync ssh
    copypath cp fzf)

source $ZSH/oh-my-zsh.sh
