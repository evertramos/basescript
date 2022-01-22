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
# 1.
#
# You must/might inform the parameters below:
# 1. Full file path
# 2. String that should be substituted
# 3. String that will replace the string above (2)
# 4. [optional] (default: false) exit on error
# 5. [optional] (default: false) update a variable value
#
# Just to clarify a little bit, the 5th parameter will replace a regular
# string with the new value, but if you set 'true' it will replace only
# the value after the equal sign ('=') as widely used in .env files
#
#-----------------------------------------------------------------------

file_update_file()
{
    local LOCAL_FULL_FILE_PATH LOCAL_FROM_STRING LOCAL_TO_STRING LOCAL_STOP_EXECUTION_ON_ERROR LOCAL_UPDATE_VARIABLE_VALUE LOCAL_ALLOW_RUN_WITH_SUDO LOCAL_RUN_WITH_SUDO

    LOCAL_FULL_FILE_PATH=${1:-null}
    LOCAL_FROM_STRING=${2:-null}
    LOCAL_TO_STRING=${3:-null}
    LOCAL_STOP_EXECUTION_ON_ERROR=${4:-false}
    LOCAL_UPDATE_VARIABLE_VALUE=${5:-false} 
    LOCAL_ALLOW_RUN_WITH_SUDO=${ALLOW_RUN_WITH_SUDO:-true}

    # Check required 
    [[ $LOCAL_TO_STRING == "" || $LOCAL_TO_STRING == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    # Check if file exists | exit if 4th parameter is set to 'true'
    [[ ! -f $LOCAL_FULL_FILE_PATH ]] && [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && echoerror "We could not find the file '$LOCAL_FULL_FILE_PATH' in your local folder. \n Please inform the correct location and try again (function: ${FUNCNAME[0]})."

    # Stop execution and return error if "$LOCAL_STOP_EXECUTION_ON_ERROR" is false
    if [[ ! -f $LOCAL_FULL_FILE_PATH ]]; then
        echoerror "We could not find the file '$LOCAL_FULL_FILE_PATH' in your local folder. \n Please inform the correct location and try again (function: ${FUNCNAME[0]})." false
        FILE_UPDATE_FILE_ERROR=true
        return 0
    fi

    # Debug message 
    [[ "$DEBUG" == true ]] && echoline "Replace '$LOCAL_FROM_STRING' to '$LOCAL_TO_STRING' in '$LOCAL_FULL_FILE_PATH'."

    # Allows 'sudo' to run this function if destination path it's not owned by the current user
    [[ "$LOCAL_ALLOW_RUN_WITH_SUDO" == true ]] && ! system_check_user_folder_owner ${LOCAL_FULL_FILE_PATH%/*} && LOCAL_RUN_WITH_SUDO=sudo

    cd $(dirname $LOCAL_FULL_FILE_PATH) >/dev/null 2>&1
    if [[ "$LOCAL_UPDATE_VARIABLE_VALUE" == true ]]; then
        # To remove dots (.) use the line below
#        $LOCAL_RUN_WITH_SUDO sed -i "/$LOCAL_FROM_STRING=/c\\$LOCAL_FROM_STRING=${LOCAL_TO_STRING//.}" $LOCAL_FULL_FILE_PATH
        $LOCAL_RUN_WITH_SUDO sed -i "/$LOCAL_FROM_STRING=/c\\$LOCAL_FROM_STRING=$LOCAL_TO_STRING" $LOCAL_FULL_FILE_PATH
    else
        $LOCAL_RUN_WITH_SUDO sed -i -e "s/$LOCAL_FROM_STRING/$LOCAL_TO_STRING/g" $LOCAL_FULL_FILE_PATH
    fi
    cd - > /dev/null 2>&1
}
