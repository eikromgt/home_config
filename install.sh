#! /usr/bin/bash

echo "Start install configuration files"

rsync -av  home/ ~/

echo "Installing kitty theme"
git clone https://github.com/wdomitrz/kitty-gruvbox-theme.git ~/.config/kitty/kitty-gruvbox-theme

echo "Installing yazi theme"
ya pkg add bennyyip/gruvbox-dark

echo "Installing zathura theme"
git clone https://github.com/eastack/zathura-gruvbox.git ~/.config/zathura/zathura-gruvbox

echo "Installing zsh plugin: zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.local/share/oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing zsh plugin: zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.local/share/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh plugin: zsh-output-highlighting"
git clone https://github.com/l4u/zsh-output-highlighting.git ${ZSH_CUSTOM:-~/.local/share/oh-my-zsh/custom}/plugins/zsh-output-highlighting

echo "Finished!"
