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
# 1. Check if user has permission on specific folder
#
# You must/might inform the parameters below:
# 1. Full path of the folder you are checking
#
#-----------------------------------------------------------------------

system_check_user_folder_owner()
{
    local LOCAL_PATH
     
    LOCAL_PATH=${1:-null}

    [[ $LOCAL_PATH == "" || $LOCAL_PATH == null ]] && echoerror "You must inform the folder path to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking permissions in path '$LOCAL_PATH'."

    if [[ "$(stat -c '%u' ${LOCAL_PATH})" == "$UID" ]]; then
        SYSTEM_CHECK_USER_FOLDER_OWNER=true
        return 0
    else
        SYSTEM_CHECK_USER_FOLDER_OWNER=false
        return 1
    fi
}

