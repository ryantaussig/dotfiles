#!/usr/bin/env bash

########
# author: ryantaussig
# license: MIT
#
# abstract:
#   The following script installs dotfiles and applications interactively. It is intended for Ubuntu/Debian systems.
#   NOTE: applications and options are installed *globally*.
########

set -euo pipefail

# install settings
DOTFILES_DIR="$HOME/dotfiles"
OLD_DIR="$HOME/dotfiles_old"
DOTFILES="
vimrc
bashrc
tmux.conf
profile
tigrc
"
GOVERSION="1.12.5"
GOARCH="linux-amd64"

# install dotfile symlinks
echo "Installing dotfile symlinks."
mkdir -p $OLD_DIR
pushd $DOTFILES_DIR
for DOTFILE in $DOTFILES; do
	if [[ -f "$HOME/.$DOTFILE" ]]; then
		echo "Moving existing $DOTFILE to $OLD_DIR"
		mv $HOME/.$DOTFILE $OLD_DIR
	fi
	echo "Creating symlink to $DOTFILE in $HOME"
	ln -s $DOTFILES_DIR/$DOTFILE $HOME/.$DOTFILE
done
echo "Dotfile installation complete. Backups of the originals are located in $OLD_DIR."
popd

# TODO: add a switch to allow installing with various package managers
# update package index prior to application installs
echo "Updating package index."
sudo apt update

# headless applications/utilities
while true; do
	read -rp "Do you wish to install the headless/server applications? (y/n): " CLI
	if [[ "$CLI" == "y" ]]; then
		echo "Installing..."
		sudo apt install -y vim-nox tmux git ssh tree lnav peco tig ranger ncdu htop curl wget w3m w3m-img iperf mycli
	elif [[ "$CLI" == "n" ]]; then
		echo "Skipping..."
	else
		echo "Please respond y or n."
		continue
	fi
	break
done

# workstation applications
while true; do
	read -rp "Do you wish to install the GUI/workstation applications and settings? (y/n): " GUI
	if [[ "$GUI" == "y" ]]; then
		echo "Installing..."

		# install general packages
		sudo apt install -y gnome-terminal pandoc cmus ripit mpv youtube-dl dict dict-* vlc libreoffice gnome-tweaks vim-gui-common pavucontrol snapd

		# install chat clients
		sudo snap install discord
		sudo snap install slack --classic
		sudo snap install skype --classic

		# install VA-API enabled chromium and drivers (enabled via chrome://flags)
		# NOTE: currently won't work with some DRM sites like netflix---use firefox in those cases
		sudo add-apt-repository ppa:saiarcot895/chromium-dev
		sudo apt update && sudo apt install -y chromium-browser i965-va-driver

		# install work stuff
		sudo apt install -y docker.io certbot openssl zstd php composer python3 python3-phpserialize python3-mysql.connector nodejs npm
		sudo snap install google-cloud-sdk --classic
		sudo snap install kubectl --classic
		sudo snap install aws-cli --classic
		sudo wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/local/bin/cloud_sql_proxy

		# install golang manually using specified version and architecture
		wget https://golang.org/dl/go$GOVERSION.$GOARCH.tar.gz -O /tmp/go$GOVERSION.$GOARCH.tar.gz
		sudo mkdir -p /usr/local/go
		sudo tar -xvzf /tmp/go$GOVERSION.$GOARCH.tar.gz -C /usr/local/go --strip-components=1
		rm /tmp/go$GOVERSION.$GOARCH.tar.gz

		# enable thinkpad battery features and temperature monitoring:
		sudo apt install tlp powerstat acpi-call-dkms psensor # acpi-call may no longer be needed in future kernel versions

		# install vim addons using vim 8's built-in package management and create symlinks in ~/.vim for easy upgrade management
		echo "Installing vim addons."
		sudo git clone https://github.com/morhetz/gruvbox /usr/local/src/gruvbox
		sudo git clone https://github.com/vim-airline/vim-airline /usr/local/src/vim-airline
		sudo git clone https://github.com/tpope/vim-fugitive /usr/local/src/vim-fugitive
		mkdir -p $HOME/.vim/pack/addons/{start,opt}/
		ln -s /usr/local/src/gruvbox $HOME/.vim/pack/addons/start/gruvbox
		ln -s /usr/local/src/vim-airline $HOME/.vim/pack/addons/start/vim-airline
		ln -s /usr/local/src/vim-fugitive $HOME/.vim/pack/addons/start/vim-fugitive

		# install fonts patched with powerline symbols (required for terminal themes and vim/tmux addons)
		echo "Installing powerline fonts."
		git clone https://github.com/powerline/fonts /tmp/powerline-fonts
		# change powerline's install script to install globally
		sed -i 's/$HOME\/.local/\/usr\/local/g' /tmp/powerline-fonts/install.sh
		sudo /tmp/powerline-fonts/install.sh
		rm -rf /tmp/powerline-fonts

		# install texpander and dependencies
		echo "Installing Texpander. NOTE: Remember to add a keyboard shortcut."
		sudo apt install -y xsel xdotool zenity
		sudo git clone https://github.com/leehblue/texpander /usr/local/src/texpander
		mkdir $HOME/.texpander

		echo "Importing gnome terminal themes."
		dconf load /org/gnome/terminal/ < $DOTFILES_DIR/org-gnome-terminal.dconf
	elif [[ "$GUI" == "n" ]]; then
		echo "Skipping..."
	else
		echo "Please respond y or n."
		continue
	fi
	break
done

echo SUCCESS

########
# other (misc. applications, not currently needed, explore at a later date)
########

## docs
#pip3 install mkdocs mkdocs-material

## ham radio
#sudo apt install -y chirp hamradio* ax25-applications ax25-applications ax25-xapplications ax25mail-utils gnuradio gnuradio-dev gnuradio-doc direwolf direwolf-docs

## data and design
#sudo apt install -y octave-* freecad

## private cloud messaging slack/discord/irc alternatives
#sudo apt install -y matrix-synapse revolt
#sudo snap install -y mattermost-desktop

