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
# 1. Check if folder exists
#
# You must/might inform the parameters below:
# 1. Folder full path
# 2. [optional] (default: false) Output message if folder does not exist
#
#-----------------------------------------------------------------------

check_folder_exists() 
{
    local LOCAL_FOLDER LOCAL_ECHOOUT

    LOCAL_FOLDER=${1:-null}
    
    LOCAL_ECHOOUT=${2:-false}

    [[ $LOCAL_FOLDER == "" || $LOCAL_FOLDER == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if folder '$LOCAL_FOLDER' exists."

    [[ "$LOCAL_ECHOOUT" == true ]] && [[ ! -d "$LOCAL_FOLDER" ]] && echoerror "Folder '$LOCAL_FOLDER' does not exist"

    if [[ -d "$LOCAL_FOLDER" ]]; then
       FOLDER_EXIST=true
    else
       FOLDER_EXIST=false
    fi

    return 0
}
