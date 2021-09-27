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
# 4. [optional] (default: false) Skip all security validation
#
#-----------------------------------------------------------------------

# ----------------------------------------------------------------------
# [IMPORTANT]
# Use this function with caution! We recommend yout to set the second
# argument in order to restrict your script actions in a specific
# folder path and keep an eye on the SUDO option on deleting
# ----------------------------------------------------------------------
system_safe_delete_folder()
{
    local LOCAL_SAFE_DELETE_FOLDER LOCAL_ALLOWED_DELETE_BASE_PATH LOCAL_SAFE_DELETE_FOLDER_BASE_PATH

    LOCAL_SAFE_DELETE_FOLDER=${1%/}
    LOCAL_ALLOWED_DELETE_BASE_PATH=${2:-server}
    DELETE_USING_SUDO=${3:-false}
    LOCAL_ALLOWED_DELETE_BASE_PATH=${LOCAL_ALLOWED_DELETE_BASE_PATH%/}
    SKIP_ALL_VALIDATION=${4:-false}

    [[ $LOCAL_SAFE_DELETE_FOLDER == "" ]] && echoerror "You must inform a path as an argument to the function '${FUNCNAME[0]}'"
    [[ $LOCAL_ALLOWED_DELETE_BASE_PATH == "" ]] && echoerror "It seems you have tried to delete an unauthorized path. Please watch your fingers! \n path: '$LOCAL_SAFE_DELETE_FOLDER' - function: '${FUNCNAME[0]}'"

    # Safe check if root of deletion folder is '/' or '.' or '..'
    # avoiding delete a system folders
    if [[ "$SKIP_ALL_VALIDATION" != true ]]; then
        LOCAL_SAFE_DELETE_FOLDER_BASE_PATH=${LOCAL_SAFE_DELETE_FOLDER#/}
        LOCAL_SAFE_DELETE_FOLDER_BASE_PATH=${LOCAL_SAFE_DELETE_FOLDER_BASE_PATH%%/*}
        [[ $LOCAL_SAFE_DELETE_FOLDER_BASE_PATH == *"."* ]] || [[ $LOCAL_SAFE_DELETE_FOLDER_BASE_PATH == *"/"* ]] && echoerror "Gotcha you! You action did not pass our safe deletion mode,\nthe path can not contain dots (.) or be null, which implies a system root folder."
        [[ $LOCAL_ALLOWED_DELETE_BASE_PATH != ${LOCAL_SAFE_DELETE_FOLDER:0:${#LOCAL_ALLOWED_DELETE_BASE_PATH}} ]] && echoerror "You are not authorized to delete '$LOCAL_SAFE_DELETE_FOLDER'"
    fi

    [[ "$DEBUG" == true ]] && echowarning "Deleting folder '$LOCAL_SAFE_DELETE_FOLDER'"

    if [[ "$DELETE_USING_SUDO" == true ]]; then
        sudo rm -rf $LOCAL_SAFE_DELETE_FOLDER
    else
        rm -rf $LOCAL_SAFE_DELETE_FOLDER
    fi

    return 0
}
