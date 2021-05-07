#!/usr/bin/

#-----------------------------------------------------------------------
#
# Basescript function
#
# The basescript functions were designed to work as abstract function,
# so it could be used in many different contexts executing specific job
# always remembering Unix concept DOTADIW - "Do One Thing And Do It Well"
#
# Developed by
#   Evert Ramos <evert.ramos@gmail.com>
#
# Copyright Evert Ramos
#
#-----------------------------------------------------------------------
#
# Be careful when editing this file, it is part of a bigger scripts!
#
# Basescript - https://github.com/evertramos/basescript
#
#-----------------------------------------------------------------------
#
# source: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
#
# ----------------------------------------------------------------------
# This script has one main objective:
# 1. Set colors for output messages
#
# ----------------------------------------------------------------------

# Colors on output
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
lightgreen=`tput setaf 6`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 75`
white=`tput setaf 7`
purple=`tput setaf 129`

reset=`tput sgr0`
