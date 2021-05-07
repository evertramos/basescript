#!/usr/bin/bash

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
# 1. Set symbols for output messages
#
# ----------------------------------------------------------------------

# Symbols on output
check="\u2714"
cross="\u274c"
