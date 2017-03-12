#!/usr/bin/env bash

########
# author: ryantaussig
# last update: 2017-03-12
# license: MIT/Expat
#
# abstract:
#   the following script installs basic applications and corresponding documentation.
########

# install vim

sudo apt-get install vim-nox vim-doc

# install gvim

sudo apt-get install vim-gnome

# install git (should already be installed if this script was obtained from github)

sudo apt-get install git git-doc

# install python and python3 (almost certainly already installed)

sudo apt-get install python python3 python-doc python3-doc

# install ssh metapackage

sudo apt-get install ssh

# install w3m with image support

sudo apt-get install w3m w3m-img

# install asciidoctor

sudo apt-get install asciidoctor asciidoctor-doc

# install sphinx, related packages, and documentation

sudo apt-get install python-sphinx python3-sphinx rst2pdf python-doc8 python3-doc8 python-numpydoc python3-numpydoc python-doc8-doc sphinx-doc

# install libreoffice metapackage

sudo apt-get install libreoffice

# install octave, its extended packages, and documentation

sudo apt-get install octave*

# install scipy stack for python 2

sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose2

# install scipy stack for python 3

sudo apt-get install python3-numpy python3-scipy python3-matplotlib ipython3 ipython3-notebook python3-pandas python3-sympy python3-nose2

# install documentation for scipy stack

sudo apt-get install python-doc python-examples python3-doc python3-examples python-numpy-doc python-scipy-doc python-matplotlib-doc ipython-doc python-pandas-doc python-sympy-doc python-nose2-doc 

# install supplements to scipy stack with documentation

sudo apt-get install python-pyfftw python3-pyfftw cython cython cython-doc

# install freecad and documentation

sudo apt-get install freecad freecad-doc freecad-dev

# install amateur radio applications with available documentation

sudo apt-get install chirp hamradio* ax25-apps ax25-tools ax25-xtools ax25mail-utils gnuradio gnuradio-dev gnuradio-doc direwolf direwolf-docs

# install youtube-dl

sudo apt-get install youtube-dl

# install dictionary, thesaurus, and gazetteer

sudo apt-get install dict dict-*
