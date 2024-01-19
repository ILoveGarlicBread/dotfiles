#!/bin/bash

# Post-install set up script
# WARNING:
# - This script is designed to be used after a fresh install of Endeavour OS with Gnome desktop.
# - This is my very first bash script, certain things may not work as expected.

cd

function main() {

	timedatectl set-local-rtc 1 --adjust-system-clock
	# Gnome settings
	echo "Enabling tap to click..."
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
	echo "Tap to click status: "
	gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click

	echo "\nAdjusting volume step..."
	gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 1
	echo -n "Volume step = "
	gsettings get org.gnome.settings-daemon.plugins.media-keys volume-step

	# Move config files
	echo "\nMoving .zshrc..."
	cp ~/dotfiles/.zshrc ~/

	echo "\nMoving kitty..."
	mkdir -p ~/.config/kitty/
	cp -r ~/dotfiles/.config/kitty ~/.config/

	echo "\nMoving fastfetch..."
	mkdir -p ~/.config/fastfetch/
	mkdir -p ~/Pictures/
	cp ~/dotfiles/.config/fastfetch/config.jsonc ~/.config/fastfetch/
	cp -r ~/dotfiles/Logos ~/Pictures/Logos/

	echo "\nApplying fonts..."
	mkdir -p ~/.local/share/fonts/
	cp -r ~/dotfiles/fonts ~/.local/share/
	# Set fonts
	gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
	gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font Mono weight=450 10'
	gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto Bold 11'

	echo "\nApplying cursor"
	cd
	git clone https://github.com/vinceliuice/Qogir-icon-theme.git
	cp -r ~/Qogir-icon-theme/src/cursors/dist-ubuntu-dark ~/.local/share/icons/Qogir-ubuntu-white-cursors
	gsettings set org.gnome.desktop.interface cursor-theme 'Qogir-ubuntu-white-cursors'
	rm -rf ~/Qogir-icon-theme

	echo "\nApplying icon theme"
	cd
	git clone https://github.com/alvatip/Nordzy-icon
	cd Nordzy-icon
	./install.sh -t yellow -c dark
	cd
	gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-yellow-dark'
	rm -rf ~/Nordzy-icon

	echo "\nApplying gnome theme ..."
	git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
	cd Colloid-gtk-theme
	./install.sh --tweaks nord rimless float
	cd
	gsettings set org.gnome.desktop.interface gtk-theme "Colloid-Dark-Nord"
	gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Dark-Nord'
	rm -rf ~/Colloid-gtk-theme

	echo "\nApplying wallpapers"
	cd
	cp -r ~/dotfiles/Wallpapers ~/Pictures/
	gsettings set org.gnome.desktop.background picture-uri-dark ~/Pictures/Wallpapers/Lake_House_Nord.png

	echo "\nApplying kmonad config"
	mkdir -p ~/.config/kmonad
	cp -r ~/dotfiles/kmonad ~/.config/kmonad/
	mkdir -p ~/.config/autostart
	cp ~/dotfiles/autostart/kmonad.desktop ~/.config/autostart/

	# Installing packages
	packages=(
		zsh
		ifplugd
		kitty
		fortune-mod
		fastfetch
		neovim
		extension-manager
		qbittorrent
		optimus-manager
		gdm-prime
		libgda
		ranger
		bat
		jq
		sl
		lsd
		python-pip
		spotify
		spicetify-cli
		spicetify-marketplace-bin
		qemu
		virt-manager
		tlpui
		realneptune
		vlc
		sox
		rmtrash
		timeshift
		discord
		thunderbird
		lollypop
		yazi
	)

	for package in "${packages[@]}"; do
		yay -S --noconfirm "$package"
	done

	# Setup zsh shell
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cd
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
	git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

	# Setup neovim
	rm -rf ~/.config/nvim
	mkdir -p ~/.config/nvim
	git clone https://github.com/ILoveGarlicBread/neovim.git ~/.config/nvim/

	# Install gnome extensions and apply config
	cd ~/dotfiles/
	./install-gnome-extensions.sh --enable --file links.txt
	cd
	dconf load /org/gnome/shell/extensions/ <~/dotfiles/extensions.conf

}

main
