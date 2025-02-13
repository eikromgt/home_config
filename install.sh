#! /usr/bin/bash

echo "Start install configuration files"

rsync -av  home ~

echo "Installing yazi themes"
ya pack -a bennyyip/gruvbox-dark

echo "Installing zathura themes"
git clone https://github.com/eastack/zathura-gruvbox.git ~/.config/zathura/zathura-gruvbox

echo "Finished!"
