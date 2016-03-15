#!/usr/bin/env bash

########
# author: ryantaussig
# last updated: 2016-03-15
# license: GPLv2.0
# 
# abstract: custom UI settings for GNOME systems
########

gsettings set com.canonical.indicator.datetime time-format 'custom'
gsettings set com.canonical.indicator.datetime custom-time-format '%F %T %Z'
