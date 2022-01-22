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
# 1. Update variables in '.env' files
#
# You must/might inform the parameters below:
# 1. Full path to the env file
# 2. Variable that should be updated
# 3. New value for the variable
# 4. [optional] (default: .env) .env file name
# 5. [optional] (default: false) Create .env file if not exist
#
#-----------------------------------------------------------------------

env_update_variable()
{
    local LOCAL_FULL_PATH LOCAL_VARIABLE LOCAL_NEW_VALUE LOCAL_CREATE_IF_NOT_EXIST LOCAL_ENV_FINAL_FILE LOCAL_STOP_EXECUTION_ON_ERROR

    LOCAL_FULL_PATH=${1}
    LOCAL_VARIABLE=${2%=}
    LOCAL_NEW_VALUE=${3}
    LOCAL_ENV_FILE_NAME=${4:-".env"}
    LOCAL_CREATE_IF_NOT_EXIST=${5:-false}
    LOCAL_ENV_FINAL_FILE="${LOCAL_FULL_PATH%/}/${LOCAL_ENV_FILE_NAME}"
    LOCAL_STOP_EXECUTION_ON_ERROR=${6:-false}

    [[ $LOCAL_NEW_VALUE == "" || $LOCAL_NEW_VALUE == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}' \nReplace string: $LOCAL_VARIABLE"

    [[ "$DEBUG" == true ]] && echo "[env_update_variable] Create '$LOCAL_ENV_FINAL_FILE' at '$LOCAL_FULL_PATH' if it does not exists."
    [[ "$LOCAL_CREATE_IF_NOT_EXIST" == true ]] && env_create_if_not_exists $LOCAL_FULL_PATH

    [[ "$DEBUG" == true ]] && echo "[env_update_variable] Updating in '$LOCAL_ENV_FINAL_FILE' the variable '$LOCAL_VARIABLE' with value '$LOCAL_NEW_VALUE'"
    file_update_file $LOCAL_ENV_FINAL_FILE $LOCAL_VARIABLE $LOCAL_NEW_VALUE $LOCAL_STOP_EXECUTION_ON_ERROR true

    if [[ "$FILE_UPDATE_FILE_ERROR" == true ]]; then
        ENV_UPDATE_VARIABLE_ERROR=true
    fi
}
