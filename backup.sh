#!/bin/bash

cp -r ~/.config/kitty ~/dotfiles/.config
cp -r ~/.config/fastfetch ~/dotfiles/.config
cp -r ~/.config/kmonad ~/dotfiles/.config
cp ~/.config/autostart/kmonad.desktop ~/dotfiles/.config/autostart
dconf dump /org/gnome/shell/extensions/ >~/dotfiles/extensions.conf
