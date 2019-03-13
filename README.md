# dotfiles

| author       | Ryan Taussig |
| ------------ | ------------ |
| last updated | 2019-03-13   |

## License

Copyright (c) 2015-2019 Ryan Taussig  

The files contained within this git repository are provided free of charge.
You may redistribute or modify them according to the terms of the MIT/Expat License.
Please see the included LICENSE file.

## Notice

To apply the configuration, edit the `make-symlinks.sh` and `install-apps.sh` scripts to reflect which dotfiles and applications you want to utilize.
By default, the symlink script only applies vim and tmux settings.
The install script groups applications by environment and prompts the user for each group of apps.
After making necessary edits to the setup scripts follow this procedure:

1. Run the `install-apps.sh` script to install required applications and misc settings.
1. Run `make-symlinks.sh` to create symlinks pointing to the `~/dotfiles` directory.
1. If the GUI settings from `install-apps.sh` were declined, load the gnome-terminal settings manually with `cat dotfiles/gnome-terminal.dconf | dconf load /org/gnome/terminal/`.
