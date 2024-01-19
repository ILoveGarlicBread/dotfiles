#!/bin/bash

# Post-install set up script

cd

function main() {

	timedatectl set-local-rtc 1 --adjust-system-clock
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

	gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
	gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font Mono weight=450 10'
	gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto Bold 11'
	if [ $? -eq 0 ]; then
		echo "Fonts applied successfully"
	fi
	echo""

	echo "Applying theme..."
	mkdir -p ~/.themes
	cp -r ~/dotfiles/.themes/Colloid-Dark-Nord ~/.theme/
	gsettings set org.gnome.desktop.interface gtk-theme "Colloid-Dark-Nord"

	echo "Applying kmonad config"
	mkdir -p ~/.config/kmonad

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
		libgda
		ranger
		bat
		jq
		sl
		lsd
		python-pip
		spotify
		spicetify-cli
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
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cd
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	rm -rf ~/.config/nvim
	git clone git@github.com:ILoveGarlicBread/neovim.git ~/.config/neovim
	# Install gnome extensions and apply config
	cd ~/dotfiles/
	#./install-gnome-extensions.sh --enable --file links.txt
	cd
	dconf load /org/gnome/shell/extensions/ <~/dotfiles/extensions.conf

}

main
