#!/usr/bin/env bash

########
# author: ryantaussig
# last update: 2017-01-21
# license: GPLv2.0
#
# abstract:
#   the following script installs basic applications and corresponding documentation.
########

# install gvim

sudo apt-get install vim-gnome vim-doc

# install git (should already be installed if this script was obtained from github)

sudo apt-get install git git-doc

# install asciidoctor

sudo apt-get install asciidoctor asciidoctor-doc

# install libreoffice metapackage

sudo apt-get install libreoffice

# install octave, its extended packages, and documentation

sudo apt-get install octave*

# install scipy stack for python 2

sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose2

# install scipy stack for python 3

sudo apt-get install python3-numpy python3-scipy python3-matplotlib ipython3 ipython3-notebook python3-pandas python3-sympy python3-nose2

# install available documentation for scipy stack

sudo apt-get install python-numpy-doc python-scipy-doc python-matplotlib-doc ipython-doc python-pandas-doc python-sympy-doc python-nose2-doc

# install supplements to scipy stack

sudo apt-get install python-pyfftw python3-pyfftw cython cython3 cython-doc

# install freecad and documentation

sudo apt-get install freecad freecad-doc freecad-dev

# install amateur radio applications

sudo apt-get install chirp hamradio* ax25* gnuradio*

# install youtube-dl

sudo apt-get install youtube-dl

# install dictionary, thesaurus, and gazetteer

sudo apt-get install dict dict-*
