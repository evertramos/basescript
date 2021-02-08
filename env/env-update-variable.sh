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
# Be carefull when editing this file, it is part of a bigger script!
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
# 4. [optional] (default: false) Create .env file if not exist
#
#-----------------------------------------------------------------------

env_update_variable()
{
    local LOCAL_FULL_PATH LOCAL_VARIABLE LOCAL_NEW_VALUE LOCAL_CREATE_IF_NOT_EXIST LOCAL_ENV_FINAL_FILE

    LOCAL_FULL_PATH=${1}
    LOCAL_VARIABLE=${2%=}
    LOCAL_NEW_VALUE=${3}
    LOCAL_CREATE_IF_NOT_EXIST=${4:-false}
    LOCAL_ENV_FINAL_FILE="${LOCAL_FULL_PATH%/}/.env"
 
    [[ $LOCAL_NEW_VALUE == ""  || $LOCAL_NEW_VALUE == null ]] && echoerr "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Updating in '$LOCAL_ENV_FINAL_FILE' the variable '$LOCAL_VARIABLE' with value '$LOCAL_NEW_VALUE'"

    [[ "$LOCAL_CREATE_IF_NOT_EXIST" == true ]] && env_create_if_not_exists $LOCAL_FULL_PATH
   
    if [[ ! -f "$LOCAL_ENV_FINAL_FILE" ]]; then
        REPONSE_ENV_UPDATE_VARIABLE="File '$LOCAL_ENV_FINAL_FILE' does not exist."
        return 0
    fi

    sed -i '/'"$LOCAL_VARIABLE"'/c\'"$LOCAL_VARIABLE=$LOCAL_NEW_VALUE"'' $LOCAL_ENV_FINAL_FILE

    return 0
}
