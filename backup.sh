#!/bin/bash


cp ~/.zshrc ~/dotfiles/
cp -r ~/.config/kitty ~/dotfiles/.config
cp -r ~/.config/fastfetch ~/dotfiles/.config
dconf dump /org/gnome/shell/extensions/ > ~/dotfiles/extensions.conf 



