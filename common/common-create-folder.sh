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
# 1. Function/Script to create a folder if it does not exists
#
# You must/might inform the parameters below:
# 1. Folder name that should be created
# 2. [optional] (default: true) Stop script execution on error
#
#-----------------------------------------------------------------------

common_create_folder()
{
    local LOCAL_FOLDER LOCAL_STOP_EXECUTION_ON_ERROR LOCAL_ALLOW_RUN_WITH_SUDO LOCAL_RUN_WITH_SUDO

    LOCAL_FOLDER=${1}
    LOCAL_STOP_EXECUTION_ON_ERROR=${2:-true}
    LOCAL_ALLOW_RUN_WITH_SUDO=${ALLOW_RUN_WITH_SUDO:-true}

    [[ $LOCAL_FOLDER == "" ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Creating folder '$LOCAL_FOLDER'"

    # Allows 'sudo' to run this function if destination path it's not owned by the current user
    [[ "$LOCAL_ALLOW_RUN_WITH_SUDO" == true ]] && ! system_check_user_folder_owner ${LOCAL_FOLDER%/*} && LOCAL_RUN_WITH_SUDO=sudo

    $LOCAL_RUN_WITH_SUDO mkdir -p $LOCAL_FOLDER > /dev/null 2>&1

    [[ ! -d "$LOCAL_FOLDER" ]] && [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && echoerror "The folder '$LOCAL_FOLDER' could not be created. \nCheck folder permissions."

    [[ ! -d "$LOCAL_FOLDER" ]] && COMMON_CREATE_FOLDER_ERROR = true

    return 0
}
