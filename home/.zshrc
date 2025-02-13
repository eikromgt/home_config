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

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="kolo"

CASE_SENSITIVE="true"

plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting zsh-output-highlighting)

source $ZSH/oh-my-zsh.sh
