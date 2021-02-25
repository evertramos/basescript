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
# 1. Safely delete folder at the allowed places
#
# You must/might inform the parameters below:
# 1. Folder path you want to delete
# 2. [optional] (default: 'server') The path allowed by the script to
# delete the requested folder, it can not be empty ('/')
# 3. [optional] (default: false) Delete using 'sudo' option
#
#-----------------------------------------------------------------------

# ----------------------------------------------------------------------
# [IMPORTANT]
# Use this function with caution! We recommend to always set the second
# argument in order to keep restrict your script actions to a specific
# path in your server and keep an eye on the SUDO option on deleting
# ----------------------------------------------------------------------
system_safe_delete_folder()
{
    local LOCAL_SAFE_DELETE_FOLDER LOCAL_ALLOWED_DELETE_BASE_PATH LOCAL_BASE_PATH

    LOCAL_SAFE_DELETE_FOLDER=${1%/}
    LOCAL_ALLOWED_DELETE_BASE_PATH=${2:-server}
    DELETE_USING_SUDO=${3:-true}
    LOCAL_ALLOWED_DELETE_BASE_PATH=${LOCAL_ALLOWED_DELETE_BASE_PATH%/}

    [[ $LOCAL_SAFE_DELETE_FOLDER == "" ]] && echoerr "You must inform a path as an argument to the function '${FUNCNAME[0]}'"
    [[ $LOCAL_ALLOWED_DELETE_BASE_PATH == "" ]] && echoerr "It seems you have tried to delete an unauthorized path. Please watch your fingers! \n path: '$LOCAL_SAFE_DELETE_FOLDER' - function: '${FUNCNAME[0]}'"

    LOCAL_BASE_PATH=${LOCAL_SAFE_DELETE_FOLDER#/}
    LOCAL_BASE_PATH=${LOCAL_BASE_PATH%%/*}
    [[ $LOCAL_ALLOWED_DELETE_BASE_PATH != $LOCAL_BASE_PATH ]] && echoerr "You are not authorized to delete '$LOCAL_SAFE_DELETE_FOLDER'"
    
    [[ "$DEBUG" == true ]] && echowarning "Deleting folder '$LOCAL_SAFE_DELETE_FOLDER'"

    if [[ "$DELETE_USING_SUDO" == true ]]; then
        sudo rm -rf $LOCAL_SAFE_DELETE_FOLDER
    else
        rm -rf $LOCAL_SAFE_DELETE_FOLDER
    fi

    return 0
}
