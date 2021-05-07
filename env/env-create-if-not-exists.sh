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
    local LOCAL_FULL_PATH LOCAL_ENV_EXTENTION LOCAL_ENV_FILE_NAME LOCAL_ENV_EXAMPLE_FILE LOCAL_ENV_FINAL_FILE

    LOCAL_FULL_PATH=${1:-null}
    LOCAL_ENV_EXTENTION=${2:-".example"}
    LOCAL_ENV_FILE_NAME=${3:-".env"}
    LOCAL_ENV_EXAMPLE_FILE="${LOCAL_FULL_PATH%/}/$LOCAL_ENV_FILE_NAME$LOCAL_ENV_EXTENTION"
    LOCAL_ENV_FINAL_FILE="${LOCAL_FULL_PATH%/}/$LOCAL_ENV_FILE_NAME"

    [[ $LOCAL_FULL_PATH == "" || $LOCAL_FULL_PATH == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ -f "$LOCAL_FULL_PATH" ]] && return 0
     
    [[ "$DEBUG" == true ]] && echo "Creating file '$LOCAL_FULL_PATH'"
    
    cp $LOCAL_ENV_EXAMPLE_FILE $LOCAL_ENV_FINAL_FILE
}
