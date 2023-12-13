#!/bin/bash
# Post-install set up script
#if [ "$EUID" -ne 0 ]; then
#  echo "This script requires administrative privileges. Please run
# it with sudo."
#  exit 1
#fi


cd
# Gnome settings
echo "Enabling tap to click..."
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
echo "Tap to click status: "
gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click 
echo "Adjusting volume step..."
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 1
echo -n "Volume step: " 
gsettings get org.gnome.settings-daemon.plugins.media-keys volume-step 


# Install gnome extensions
#

# Move config files
source_folder="~/dotfiles/"
destination_folder="~/.config/"
echo "Moving .zshrc..."
cp ~/dotfiles/.zshrc ~/
if [ %? -eq 0]; then
  echo ".zshrc moved successfully."
fi
echo "Moving kitty..."
mkdir ~/.config/kitty/
cp $source_folder/.config/kitty/kitty.conf $destination_folder/kitty/
cp $source_folder/.config/kitty/nord.conf $destination_folder/kitty/
cp $source_folder/.config/kitty/everforest.conf $destination_folder/kitty/
cp $source_folder/.config/kitty/gruvbox_dark.conf $destination_folder/kitty/
if [ %? -eq 0]; then
  echo ".kitty config moved successfully."
fi

echo "Moving fastfetch..."
mkdir ~/.config/fastfetch/
cp $source_folder/.config/fastfetch/config.conf ~/.config/fastfetch/
if [ %? -eq 0]; then
  echo ".fastfetch config moved successfully."
fi
echo "Applying fonts..."
mkdir ~/.local/share/fonts/
unzip ~/dotfiles/fonts/FiraCode.zip -d ~/.local/share/fonts/
unzip ~/dotfiles/fonts/FiraSans.zip -d ~/.local/share/fonts/
unzip ~/dotfiles/fonts/MesloLGS.zip -d ~/.local/share/fonts/
gsettings set org.gnome.desktop.interface document-font-name 'Fira Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font Mono Retina 10'
gsettings set org.gnome desktop.interface font-name 'Fira Sans 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Fira Sans Bold 11'
if [ %? -eq 0]; then
  echo "Fonts applied successfully"
fi
echo "Applying theme..."
mkdir ~/.themes
unzip ~/dotfiles/.themes/Colloid-Dark-Nord.zip -d ~/.themes/
#gsettings set org.gnome.shell.extensions.user-theme name 'Colloid-Dark-Nord'

# Installing packages
packages=(
  zsh
  kitty
  fastfetch
  neovim
  extension-manager
  qbittorrent
)

#for package in "${packages[@]}"; do 
#  yay -S --noconfirm "$package"
#done





