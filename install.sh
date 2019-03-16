#!/usr/bin/env bash

########
# author: ryantaussig
# license: MIT
#
# abstract:
#   The following script installs dotfiles and applications interactively. It is intended for Ubuntu/Debian systems.
########

set -euo pipefail

# install settings
DOTFILES_DIR=$HOME/dotfiles
OLD_DIR=$HOME/tmp/dotfiles_old
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
popd

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
        sudo apt install -y gnome-terminal pandoc cmus ripit mpv youtube-dl dict dict-* vlc libreoffice gnome-tweaks python3 python3-pip
        pip3 install mkdocs mkdocs-material pygments

        # install work stuff
        sudo apt install -y google-cloud-sdk kubectl docker.io php composer nodejs npm certbot openssl mysql-workbench zstd snapd
        pip3 install phpserialize mysql-connector-python google-cloud-storage awscli
        sudo snap install -y slack --classic
        # sanity check to ensure ~/.local/bin exists
        mkdir -p $HOME/.local/bin
        wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O $HOME/.local/bin/cloud_sql_proxy

        # install chrome manually
        export GCLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
        echo "deb http://packages.cloud.google.com/apt $GCLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        rm google-chrome-stable_current_amd64.deb

        echo "Creating ~/git."
        mkdir -p $HOME/git

        # install vim addons using vim 8+ built in package management and symlinks for central git repo management
        echo "Installing vim addons."
        git clone http://github.com/morhetz/gruvbox $HOME/git/gruvbox
        git clone http://github.com/vim-airline/vim-airline $HOME/git/vim-airline
        git clone http://github.com/tpope/vim-fugitive $HOME/git/vim-fugitive
        mkdir -p $HOME/.vim/pack/addons/{start,opt}/
        ln -s $HOME/git/gruvbox $HOME/.vim/pack/addons/start/gruvbox
        ln -s $HOME/git/vim-airline $HOME/.vim/pack/addons/start/vim-airline
        ln -s $HOME/git/vim-fugitive $HOME/.vim/pack/addons/start/vim-fugitive

        # install fonts patched with powerline symbols (required for terminal themes and vim/tmux addons)
        echo "Installing powerline fonts."
        # sanity check to make sure ~/tmp exists
        mkdir -p $HOME/tmp
        git clone https://github.com/powerline/fonts $HOME/tmp/powerline-fonts
        $HOME/tmp/powerline-fonts/install.sh
        rm -rf $HOME/tmp/powerline-fonts

        # install texpander and dependencies
        echo "Installing Texpander. NOTE: Remember to add a keyboard shortcut."
        sudo apt install -y xsel xdotool zenity
        git clone https://github.com/leehblue/texpander $HOME/git/texpander
        mkdir $HOME/.texpander

        echo "Importing gnome terminal themes."
        dconf load /org/gnome/terminal < $DOTFILE_DIR/org-gnome-terminal.dconf
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

