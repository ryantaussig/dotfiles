#!/usr/bin/env bash

########
# author: ryantaussig
# last update: 2016-01-19
# license: GPLv3.0 or any later version
#
# abstract:
#   the following scipt installs the scipy stack for python 2 and 3, including documentation.
########

# install for python 2

sudo apt-get install -y python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose2

# install for python 3

sudo apt-get install -y python3-numpy python3-scipy python3-matplotlib ipython3 ipython3-notebook python3-pandas python3-sympy python3-nose2

# install available documentation (no doc in repo for pandas)

sudo apt-get install -y python-numpy-doc python-scipy-doc python-matplotlib-doc ipython-doc python-sympy-doc python-nose2-doc
