#
# ~/.zprofile
#

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export VISUAL=nvim
export EDITOR=nvim
export BROWSER=chromium
export GOPATH="$HOME/.local/share/go"

[[ -f ~/.zshrc ]] && . ~/.zshrc

if uwsm check may-start; then
  exec uwsm start hyprland.desktop > /dev/null
fi

