#!/usr/bin/env bash

########
# author: ryantaussig
# license: MIT
#
# abstract:
#   The following script installs dotfiles and applications interactively. It is intended for Ubuntu systems.
########

set -euo pipefail

# install settings
DOTFILES_DIR="$HOME/dotfiles"
OLD_DIR="$HOME/tmp/dotfiles_old"
BIN_DIR="$HOME/.local/bin"
VENDOR_DIR="$HOME/vendor"
DOTFILES="
.vimrc
.bashrc
.tmux.conf
.profile
.tigrc
.selected_editor
.editorconfig
"

# install dotfile symlinks
echo "Installing dotfile symlinks."
mkdir -p $OLD_DIR
pushd $DOTFILES_DIR
for DOTFILE in $DOTFILES; do
	if [[ -f "$HOME/$DOTFILE" ]]; then
		echo "Moving existing $DOTFILE to $OLD_DIR"
		mv $HOME/$DOTFILE $OLD_DIR
	fi
	echo "Creating symlink to $DOTFILE in $HOME"
	ln -s $DOTFILES_DIR/$DOTFILE $HOME/$DOTFILE
done
echo "Dotfile installation complete. Backups of the originals are located in $OLD_DIR."
popd

# TODO: add a switch to allow installing with other package managers
# update package index prior to application installs
echo "Updating package index."
sudo apt update

# headless applications/utilities
while true; do
	read -rp "Do you wish to install the headless/server applications? (y/n): " CLI
	if [[ "$CLI" == "y" ]]; then
		echo "Installing..."
		sudo apt install -y vim-nox tmux git ssh lnav peco tig ranger ncdu htop curl wget w3m w3m-img iperf mycli # exa not available on 19.10, install via cargo instead
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

		mkdir -p $BIN_DIR
		mkdir -p $VENDOR_DIR

		# NOTE: rust installation is best managed using `rustup`, which will prompt the user for input during install.
		# Let's do that first to get use input out of the way.
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

		# install general packages
		sudo apt install -y gnome-terminal firefox pandoc cmus ripit mpv youtube-dl vlc libreoffice gnome-tweaks vim-gtk3 pavucontrol snapd mkusb
		cargo install exa
		sudo snap install discord
		sudo snap install slack --classic
		sudo snap install skype --classic

		# install development and operations tools
		sudo apt install -y docker.io certbot openssl zstd nodejs php composer php-xml php-pear python3 python3-pip mysql-workbench
		sudo snap install code --classic
		sudo snap install google-cloud-sdk --classic
		sudo snap install kubectl --classic
		sudo snap install aws-cli --classic
		sudo snap install chromium # for debugging purposes and occasional general use when a site doesn't agree with firefox
		cargo install cargo-update # adds `cargo install-update` subcommand for updating bins (`cargo update` only does deps from Cargo.lock)
		cargo install mdbook
		cargo install deno # experiment with deno as a potential node replacement
		# NOTE: `nodejs` versions are best managed using some sort of manager, such as `n`.
		sudo npm install -g n
		sudo n stable # update node to latest stable version
		sudo npm install -g typescript
		sudo npm install -g yarn # use yarn instead of npm for package management within projects
		pip3 install phpserialize
		pip3 install mysql-connector-python
		composer global require symplify/easy-coding-standard --dev
		wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O $VENDOR_DIR/cloud_sql_proxy
		ln -s $VENDOR_DIR/cloud_sql_proxy $BIN_DIR/cloud_sql_proxy


		# install vim addons using vim 8's built-in package management and create symlinks in ~/.vim for easy upgrade management
		echo "Installing vim addons."
		git clone https://github.com/morhetz/gruvbox $VENDOR_DIR/gruvbox
		git clone https://github.com/vim-airline/vim-airline $VENDOR_DIR/vim-airline
		git clone https://github.com/tpope/vim-fugitive $VENDOR_DIR/vim-fugitive
		git clone https://github.com/sheerun/vim-polyglot $VENDOR_DIR/vim-polyglot
		git clone https://github.com/editorconfig/editorconfig-vim $VENDOR_DIR/editorconfig-vim
		mkdir -p $HOME/.vim/pack/plugins/{start,opt}/
		ln -s $VENDOR_DIR/gruvbox $HOME/.vim/pack/plugins/start/gruvbox
		ln -s $VENDOR_DIR/vim-airline $HOME/.vim/pack/plugins/start/vim-airline
		ln -s $VENDOR_DIR/vim-fugitive $HOME/.vim/pack/plugins/start/vim-fugitive
		ln -s $VENDOR_DIR/vim-polyglot $HOME/.vim/pack/plugins/start/vim-polyglot
		ln -s $VENDOR_DIR/editorconfig-vim $HOME/.vim/pack/plugins/start/editorconfig-vim

		# install fonts patched with powerline symbols (required for terminal themes and vim/tmux addons)
		echo "Installing powerline fonts."
		git clone https://github.com/powerline/fonts $HOME/tmp/powerline-fonts
		bash $HOME/tmp/powerline-fonts/install.sh
		rm -rf $HOME/tmp/powerline-fonts

		# install texpander and dependencies
		echo "Installing Texpander. NOTE: Remember to add a keyboard shortcut."
		sudo apt install -y xsel xdotool zenity
		sudo git clone https://github.com/leehblue/texpander $VENDOR_DIR/texpander
		ln -s $VENDOR_DIR/texpander/texpander.sh $BIN_DIR/texpander.sh
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

while true; do
	read -rp "Do you wish to install ThinkPad specific packages? (y/n): " TP
	if [[ "$TP" == "y" ]]; then
		echo "Installing..."
		# enable thinkpad battery features and temperature monitoring:
		sudo apt install tlp powerstat acpi-call-dkms psensor # acpi-call may no longer be needed in future kernel versions
	elif [[ "$TP" == "n" ]]; then
		echo "Skipping..."
	else
		echo "Please respond y or n."
		continue
	fi
	break
done

while true; do
	read -rp "Do you wish to install Sonic Pi? (y/n): " MUS
	if [[ "$MUS" == "y" ]]; then
		echo "Installing..."
		sudo apt install -y sonic-pi
	elif [[ "$MUS" == "n" ]]; then
		echo "Skipping..."
	else
		echo "Please respond y or n."
		continue
	fi
	break
done

echo SUCCESS

