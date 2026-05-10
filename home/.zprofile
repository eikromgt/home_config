#
# ~/.zprofile
#

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

[[ -f ~/.zshrc ]] && . ~/.zshrc

if command -v uwsm >/dev/null 2>&1 && uwsm check may-start; then
  exec uwsm start hyprland.desktop > /dev/null
fi

