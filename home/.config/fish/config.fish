set -x EDITOR helix
set -x BROWSER qutebrowser
set -x GOPATH $HOME/.local/share/go

if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
end
if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
end
