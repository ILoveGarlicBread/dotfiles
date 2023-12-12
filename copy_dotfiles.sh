#!/bin/bash
cd
echo "Copying .zshrc"
if [ -d ~/ ]; then
  cp ~/dotfiles/.zshrc ~/
fi 


if [ -d ~/.config/kitty/]; then
  cp ~/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/
  cp ~/dotfiles/.config/kitty/nord.conf ~/.config/kitty/
  cp ~/dotfiles/.config/kitty/everforest.conf ~/.config/kitty/
  cp ~/dotfiles/.config/kitty/gruvbox_dark.conf ~/.config/kitty/
else 
  mkdir ~/.config/kitty/
  cp ~/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/
  cp ~/dotfiles/.config/kitty/nord.conf ~/.config/kitty/
  cp ~/dotfiles/.config/kitty/everforest.conf ~/.config/kitty/
  cp ~/dotfiles/.config/kitty/gruvbox_dark.conf ~/.config/kitty/
fi
  





