#!/bin/bash
cd
source_folder="~/dotfiles/"
destination_folder="~/.config/"
echo "Moving .zshrc..."
cp ~/dotfiles/.zshrc ~/
if [ %? -eq 0]; then
  echo ".zshrc moved successfully."

echo "Moving kitty"
mkdir -p ~/.config/kitty/
cp ~/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/
cp ~/dotfiles/.config/kitty/nord.conf ~/.config/kitty/
cp ~/dotfiles/.config/kitty/everforest.conf ~/.config/kitty/
cp ~/dotfiles/.config/kitty/gruvbox_dark.conf ~/.config/kitty/
if [ %? -eq 0]; then
  echo ".zshrc moved successfully."


echo "Moving fastfetch"
mkdir -p ~/.config/fastfetch/
cp ~/dotfiles/.config/fastfetch/config.conf ~/.config/fastfetch/
if [ %? -eq 0]; then
  echo ".zshrc moved successfully."

  




