#!/usr/bin/env bash

########
# author: ryantaussig
# last update: 2016-11-22
# license: GPLv2.0
#
# abstract:
#   the following script installs basic applications and corresponding documentation.
########

# install gvim

sudo apt-get install vim-gnome vim-doc

# install git (should already be installed if this script was obtained from github)

sudo apt-get install git git-doc

# install libreoffice metapackage

sudo apt-get install libreoffice

# install octave and its extended packages

sudo apt-get install octave-*

# install scipy stack for python 2

sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose2

# install scipy for python 3

sudo apt-get install python3-numpy python3-scipy python3-matplotlib ipython3 ipython3-notebook python3-pandas python3-sympy python3-nose2

# install available documentation for scipy stack (no doc in repo for pandas)

sudo apt-get install python-numpy-doc python-scipy-doc python-matplotlib-doc ipython-doc python-sympy-doc python-nose2-doc
