# ryantaussig's dotfiles
author: Ryan Taussig
date: 2019-01-25

## License

Copyright (c) 2015, 2016, 2017, 2019 Ryan Taussig  

The files contained within this git repository are provided free of charge. You
may redistribute or modify them according to the terms of the MIT/Expat
License. Please see the included LICENSE file.

## Notice

To apply the dotfiles, edit the `make-symlinks.sh` script to reflect which dotfiles you want to utilize. By default, the script only applies vim settings. Afterwards follow this procedure:

1. If desired, run the `install-apps.sh` script to install required applications.
1. Run `make-symlinks.sh`
1. Load the gnome-terminal settings with `cat gnome-terminal.dconf | dconf load /org/gnome/terminal/`
