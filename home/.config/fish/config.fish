set -x VISUAL helix
set -x EDITOR helix
set -x BROWSER qutebrowser
set -x GOPATH $HOME/.local/share/go

if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
end
if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
end

direnv hook fish | source

alias lg "lazygit"
alias cssh 'TERM=xterm-256color ct autossh -M 0 -t'

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

if status is-interactive && not set -q TMUX
    if not tmux has-session -t dev 2>/dev/null
        tmux new-session -d -s dev -c $HOME
    end
end

if status is-login
    if command -v uwsm >/dev/null && uwsm check may-start
        exec uwsm start hyprland.desktop > /dev/null
    end
end

