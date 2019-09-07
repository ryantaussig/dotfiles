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
	# add user's private bin to $PATH if it exists
	if [ -d "$HOME/.local/bin" ] ; then
		PATH="$HOME/.local/bin:$PATH"
	fi

	# add user's cargo bin to $PATH if it exists
	if [ -d "$HOME/.cargo/bin" ] ; then
		PATH="$PATH:$HOME/.cargo/bin"
	fi

	# add user's global composer bin to $PATH if it exists
	if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
		PATH="$PATH:$HOME/.config/composer/vendor/bin"
	fi
fi

