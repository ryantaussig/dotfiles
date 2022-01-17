# If this is `bash`, check for and include `.bashrc`.
if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# `tmux` runs login shells creating duplicate entries in $PATH, so check if $TMUX is set first.
if [ -z "$TMUX" ]; then
	# Add user's private bin to $PATH if it exists.
    # User's actual private bin for manually installed scripts and binaries.
	if [ -d "$HOME/bin" ] ; then
		PATH="$HOME/bin:$PATH"
	fi

	# Add user's local private bin to $PATH if it exists.
    # Used by some third-party applications like `pip`.
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

