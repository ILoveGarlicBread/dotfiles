#!/bin/bash
cd
source_folder="~/dotfiles/"
destination_folder="~/.config/"
echo "Moving .zshrc"
cp ~/dotfiles/.zshrc ~/


echo "Moving kitty"
mkdir -p ~/.config/kitty/
cp ~/dotfiles/.config/kitty/ ~/.config/kitty/

echo "Moving fastfetch"
mkdir -p ~/.config/fastfetch/
cp ~/dotfiles/.config/fastfetch/ ~/.config/fastfetch/ 
  




