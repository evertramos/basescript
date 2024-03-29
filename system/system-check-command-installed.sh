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
# Be careful when editing this file, it is part of a bigger script!
#
# Basescript - https://github.com/evertramos/basescript
#
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# This function has one main objective:
# 1. Check if a command is installed 
#
# You must/might inform the parameters below:
# 1. Command name
#
#-----------------------------------------------------------------------

system_check_command_installed()
{
    local LOCAL_COMMAND
     
    LOCAL_COMMAND=${1:-null}

    [[ $LOCAL_COMMAND == "" ]] && echoerror "You must inform the COMMAND NAME to the function: '${FUNCNAME[0]}'"
 
    [[ "$DEBUG" == true ]] && echo "Checking if command '$LOCAL_COMMAND' is installed."

    if [[ ! -x "$(command -v "$LOCAL_COMMAND")" ]]; then
        COMMAND_IS_INSTALLED=false
    else
        COMMAND_IS_INSTALLED=true
    fi
}

