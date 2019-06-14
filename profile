# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if this is bash, check for and include .bashrc
if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# TMUX runs login shells creating duplicate entries in $PATH, so check if $TMUX is set first.
if [ -z "$TMUX" ]; then
	# add user's private bins to $PATH if they exist
	if [ -d "$HOME/bin" ] ; then
		PATH="$HOME/bin:$PATH"
	fi
	if [ -d "$HOME/.local/bin" ] ; then
		PATH="$HOME/.local/bin:$PATH"
	fi

	# if golang in installed, set GOROOT/GOPATH and add the associated bins to $PATH
	if [ -d "/usr/local/go/" ] ; then
		GOROOT="/usr/local/go"
		GOPATH="$HOME/go"
		PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
	fi

	# add private global composer bin to $PATH if it exists
	if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
		PATH="$PATH:$HOME/.config/composer/vendor/bin"
	fi
fi

# disable chromium warning about api keys
GOOGLE_API_KEY=""
GOOGLE_DEFAULT_CLIENT_ID=""
GOOGLE_DEFAULT_CLIENT_SECRET=""
