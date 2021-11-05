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

# ----------------------------------------------------------------------
# This function has one main objective:
# 1. Create .env file from .env.example in destination folder
#
# You must inform the parameters below:
# 1. Full path to the env file (destination folder)
# 2. [optional] .env extension string (default: .example)
# 3. [optional] .env file name (default: .env)
#
# ----------------------------------------------------------------------

env_create_if_not_exists()
{
    local LOCAL_FULL_PATH LOCAL_ENV_EXTENTION LOCAL_ENV_FILE_NAME LOCAL_ENV_EXAMPLE_FILE LOCAL_ENV_FINAL_FILE LOCAL_ALLOW_RUN_WITH_SUDO

    LOCAL_FULL_PATH=${1:-null}
    LOCAL_ENV_EXTENTION=${2:-".example"}
    LOCAL_ENV_FILE_NAME=${3:-".env"}
    LOCAL_ENV_EXAMPLE_FILE="${LOCAL_FULL_PATH%/}/$LOCAL_ENV_FILE_NAME$LOCAL_ENV_EXTENTION"
    LOCAL_ENV_FINAL_FILE="${LOCAL_FULL_PATH%/}/$LOCAL_ENV_FILE_NAME"
    LOCAL_ALLOW_RUN_WITH_SUDO=${ALLOW_RUN_WITH_SUDO:-true}

    [[ $LOCAL_FULL_PATH == "" || $LOCAL_FULL_PATH == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echoline "[env_create_if_not_exists] Checking if file '$LOCAL_ENV_FINAL_FILE' already exists."
    [[ -f "$LOCAL_ENV_FINAL_FILE" ]] && return 0
     
    [[ "$DEBUG" == true ]] && echoline "Creating file '$LOCAL_ENV_FINAL_FILE' from '$LOCAL_ENV_EXAMPLE_FILE'."

    # Allows 'sudo' to run this function if destination path it's not owned by the current user
    [[ "$LOCAL_ALLOW_RUN_WITH_SUDO" == true ]] && ! system_check_user_folder_owner ${LOCAL_FULL_PATH%/*} && LOCAL_RUN_WITH_SUDO=sudo

    $LOCAL_RUN_WITH_SUDO cp $LOCAL_ENV_EXAMPLE_FILE $LOCAL_ENV_FINAL_FILE
    [[ ! -f "$LOCAL_ENV_FINAL_FILE" ]] && echoerror "Error creating file $LOCAL_ENV_FINAL_FILE from $LOCAL_ENV_FINAL_FILE - function: '${FUNCNAME[0]}'"
}
