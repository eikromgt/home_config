#
# ~/.zprofile
#

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export VISUAL=nvim
export EDITOR=nvim
export BROWSER=chromium

httpProxy="http://127.0.0.1:7890"
export http_proxy=$httpProxy
export https_proxy=$httpProxy
export HTTP_PROXY=$httpProxy
export HTTPS_PROXY=$httpProxy

[[ -f ~/.zshrc ]] && . ~/.zshrc

if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi
