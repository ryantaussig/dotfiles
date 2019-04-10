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
DOTFILES_DIR=$HOME/dotfiles
OLD_DIR=/var/tmp/dotfiles_old
DOTFILES="
vimrc
bashrc
tmux.conf
"

# install dotfile symlinks
echo "Installing dotfile symlinks."
mkdir -p $OLD_DIR
pushd $DOTFILES_DIR
for DOTFILE in $DOTFILES; do
    if [[ -f "$HOME/.$DOTFILE"]]; then
        echo "Moving existing $DOTFILE to $OLD_DIR"
        mv $HOME/.$DOTFILE $OLD_DIR
    fi
    echo "Creating symlink to $DOTFILE in $HOME"
    ln -s $DOTFILES_DIR/$DOTFILE $HOME/.$DOTFILE
done
echo "Dotfile installation complete. Backups of the originals are located in $OLD_DIR."
popd

#TODO: add a switch to allow installing with various package managers
# update package index prior to application installs
echo "Updating package index."
sudo apt update

# headless applications/utilities
while true; do
    read -rp "Do you wish to install the headless/server applications? (y/n): " CLI
    if [[ "$CLI" == "y" ]]; then
        echo "Installing..."
        sudo apt install -y vim-nox tmux git ssh tree lnav peco tig ranger ncdu htop wget w3m w3m-img iperf mycli
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
        sudo apt install -y gnome-terminal pandoc cmus ripit mpv youtube-dl dict dict-* vlc libreoffice gnome-tweaks python3 python3-pip vim-gui-common

        # install work stuff
        sudo apt install -y google-cloud-sdk kubectl docker.io certbot openssl mysql-workbench zstd snapd
        sudo snap install -y slack --classic
        wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/local/bin/cloud_sql_proxy

        # optional stuff
        #sudo apt install -y php composer nodejs npm
        # pip packages. it is better practice to install these in a venv on a per-project basis
        #sudo -H pip3 install mkdocs mkdocs-material pygments phpserialize mysql-connector-python google-cloud-storage awscli

        # install chrome manually
        export GCLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
        echo "deb http://packages.cloud.google.com/apt $GCLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        rm google-chrome-stable_current_amd64.deb

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
        git clone https://github.com/leehblue/texpander /usr/local/src/texpander
        mkdir $HOME/.texpander

        echo "Importing gnome terminal themes."
        dconf load /org/gnome/terminal < $DOTFILES_DIR/org-gnome-terminal.dconf
    elif [[ "$GUI" == "n" ]]; then
        echo "Skipping..."
    else
        echo "Please respond y or n."
        continue
    fi
    break
done

########
# other (misc. applications, not currently needed, explore at a later date)
########

## ham radio
#sudo apt install -y chirp hamradio* ax25-applications ax25-applications ax25-xapplications ax25mail-utils gnuradio gnuradio-dev gnuradio-doc direwolf direwolf-docs

## data and design
#sudo apt install -y octave-* freecad

## private cloud messaging slack/discord/irc alternatives
#sudo apt install -y matrix-synapse revolt
#sudo snap install -y mattermost-desktop

