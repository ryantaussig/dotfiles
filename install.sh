#!/usr/bin/env bash

########
# author: ryantaussig
# license: MIT
#
# abstract:
#   The following script installs dotfiles and applications interactively. It is intended for Ubuntu/Debian systems.
########

set -euo pipefail

# settings
DOTFILES_DIR=$HOME/dotfiles
OLD_DIR=$HOME/tmp/dotfiles_old
FILES="
vimrc
vim
bashrc
tmux.conf
"

# install dotfile symlinks
echo "Installing dotfile symlinks."
mkdir -p $OLD_DIR
cd $DOTFILES_DIR
for FILE in $FILES; do
    echo "Moving any existing dotfiles to $OLD_DIR"
    mv $HOME/.$FILE $OLD_DIR
    echo "Creating symlink to $FILE in $HOME"
    ln -s $DOTFILES_DIR/$FILE $HOME/.$FILE
done

# update package index prior to application installs
echo "Updating package index."
sudo apt update

# server-side applications
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
    if [[ "$WCLI" == "y" ]]; then
        echo "Installing..."
        sudo apt install -y pandoc python3 python3-pip cmus ripit mpv youtube-dl dict dict-* vlc libreoffice gnome-tweaks vim-doc git-doc xsel xdotool zenity google-cloud-sdk kubectl docker.io php composer nodejs npm certbot openssl mysql-workbench zstd snapd
        pip3 install mkdocs mkdocs-material pygments phpserialize mysql-connector-python google-cloud-storage awscli
        sudo snap install -y slack --classic
        export GCLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
        echo "deb http://packages.cloud.google.com/apt $GCLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        rm google-chrome-stable_current_amd64.deb
        echo "Creating ~/bin for git repos."
        mkdir $HOME/bin
        pushd $HOME/bin
        echo "Cloning vim addons."
        git clone http://github.com/morhetz/gruvbox
        git clone http://github.com/vim-airline/vim-airline
        git clone http://github.com/tpope/vim-fugitive
        echo "Installing vim addons."
        mkdir -p $HOME/.vim/pack/addons/{start,opt}/
        pushd $HOME/.vim/pack/addons/start/
        ln -s $HOME/bin/gruvbox gruvbox
        ln -s $HOME/bin/vim-airline vim-airline
        ln -s $HOME/bin/vim-fugitive vim-fugitive
        popd
        echo "Installing powerline fonts."
        git clone https://github.com/powerline/powerline-fonts
        $HOME/bin/powerline-fonts/install.sh
        echo "Installing Texpander. NOTE: Remember to add a keyboard shortcut."
        git clone https://github.com/leehblue/texpander
        mkdir $HOME/.texpander
        popd
        echo "Importing gnome terminal themes."
        dconf load /org/gnome/terminal < $(dirname $0)/org-gnome-terminal.dconf
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

