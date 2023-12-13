#!/bin/bash
# Post-install set up script

cd 
  
function main()
{
# Gnome settings
echo "Enabling tap to click..."
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
echo "Tap to click status: "
gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click 
echo""
echo "Adjusting volume step..."
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 1
echo -n "Volume step = " 
gsettings get org.gnome.settings-daemon.plugins.media-keys volume-step 
echo""


# Install gnome extensions
#

# Move config files
echo "Moving .zshrc..."
cp ~/dotfiles/.zshrc ~/
if [ $? -eq 0 ]; then
  echo ".zshrc moved successfully."
fi
echo""

echo "Moving kitty..."
mkdir -p ~/.config/kitty/
cp -r ~/dotfiles/.config/kitty ~/.config/
if [ $? -eq 0 ]; then
  echo "kitty config moved successfully."
fi
echo""

echo "Moving fastfetch..."
mkdir -p ~/.config/fastfetch/
cp ~/dotfiles/.config/fastfetch/config.conf ~/.config/fastfetch/
if [ $? -eq 0 ]; then
  echo "fastfetch config moved successfully."
fi
echo""


echo "Applying fonts..."
mkdir -p ~/.local/share/fonts/
cp -r ~/dotfiles/fonts ~/.local/share/

gsettings set org.gnome.desktop.interface document-font-name 'Fira Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font Mono weight=450 10'
gsettings set org.gnome.desktop.interface font-name 'Fira Sans 11'   
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Fira Sans Bold 11'
if [ $? -eq 0 ]; then
  echo "Fonts applied successfully"
fi
echo""

echo "Applying theme..."
mkdir -p ~/.themes
cp -r ~/dotfiles/.themes/Colloid-Dark-Nord ~/.theme/
gsettings set org.gnome.desktop.interface gtk-theme "Colloid-Dark-Nord"

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
}



main


