#! /usr/bin/bash

echo "Start install configuration files"

rsync -av  home/ ~/

echo "Installing kitty theme"
git clone https://github.com/wdomitrz/kitty-gruvbox-theme.git ~/.config/kitty/kitty-gruvbox-theme

echo "Installing yazi theme"
ya pack -a bennyyip/gruvbox-dark

echo "Installing zathura theme"
git clone https://github.com/eastack/zathura-gruvbox.git ~/.config/zathura/zathura-gruvbox

echo "Finished!"
