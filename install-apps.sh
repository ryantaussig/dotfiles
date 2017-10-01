#!/usr/bin/env bash

########
# author: ryantaussig
# last update: 2017-03-12
# license: MIT
#
# abstract:
#   the following script installs basic applications and corresponding documentation.
########

# install vim and documentation

sudo apt-get install vim-nox vim-doc

# install gvim

sudo apt-get install vim-gnome

# install git (should already be installed if this script was obtained from github)

sudo apt-get install git git-doc

# install python and python3 (almost certainly already installed) and documentation

sudo apt-get install python python-doc python-examples python3 python3-doc python3-examples

# install ssh metapackage

sudo apt-get install ssh

# install w3m with image support

sudo apt-get install w3m w3m-img

# install asciidoctor

sudo apt-get install asciidoctor asciidoctor-doc

# install python-based LAPP webstack, related framework, etc.

sudo apt-get install python-django python3-django python-django-doc python-psycopg2 python3-psycopg2 python-psycopg2-doc python-sqlparse python3-sqlparse python-sqlparse-doc python-yaml python3-yaml apache2 apache2-doc postgresql postgresql-doc

# install sphinx, related packages, and documentation

sudo apt-get install python-sphinx python3-sphinx rst2pdf python-doc8 python3-doc8 python-numpydoc python3-numpydoc python-doc8-doc sphinx-doc

# install scipy stack for python 2

sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose2

# install scipy stack for python 3

sudo apt-get install python3-numpy python3-scipy python3-matplotlib ipython3 ipython3-notebook python3-pandas python3-sympy python3-nose2

# install documentation for scipy stack

sudo apt-get install python-numpy-doc python-scipy-doc python-matplotlib-doc ipython-doc python-pandas-doc python-sympy-doc python-nose2-doc 

# install supplements to scipy stack with documentation

sudo apt-get install python-pyfftw python3-pyfftw cython cython cython-doc

# install octave, its extended packages, and documentation

sudo apt-get install octave*

# install freecad and documentation

sudo apt-get install freecad freecad-doc freecad-dev

# install amateur radio applications with available documentation

sudo apt-get install chirp hamradio* ax25-apps ax25-tools ax25-xtools ax25mail-utils gnuradio gnuradio-dev gnuradio-doc direwolf direwolf-docs

# install dictionary, thesaurus, and gazetteer

sudo apt-get install dict dict-*

# install libreoffice metapackage

sudo apt-get install libreoffice

# install youtube-dl

sudo apt-get install youtube-dl
