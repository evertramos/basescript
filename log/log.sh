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
# 1. Log activities
#
# You must/might inform the parameters below:
# 1. The data what should be logged
# 2. [optional] (default: /var/log) Destination path
# 3. [optional] (default: basescript.log) Log's file name
# 4. [optional] (default: +%Y-%m-%d %H:%M:%S) Timestamp log
# 5. [optional] (default: true) Allow to run with sudo
# 6. [optional] (default: false) Stop execution on error
#
# [CAUTION] The optional argument replaces previously set parameter as of:
#   2. BASESCRIPT_LOG_BASE_PATH
#   3. BASESCRIPT_LOG_FILE_NAME
#   4. BASESCRIPT_LOG_TIMESTAMP_FLAG
#   5. ALLOW_RUN_WITH_SUDO
#   6. LOCAL_STOP_EXECUTION_ON_ERROR
#
#-----------------------------------------------------------------------

log()
{
    # Local arguments
    local LOCAL_LOG_BASE_PATH LOCAL_LOG_NAME LOCAL_TIMESTAMP_FLAG LOCAL_TIMESTAMP \
      LOCAL_LOG_FULL_PATH LOCAL_STOP_EXECUTION_ON_ERROR LOCAL_ALLOW_RUN_WITH_SUDO \
      LOCAL_RUN_WITH_SUDO

    # Optional arguments
    LOCAL_LOG_BASE_PATH="${2:-null}" && [[ "$LOCAL_LOG_BASE_PATH" == "null" ]] && LOCAL_LOG_BASE_PATH=${BASESCRIPT_LOG_BASE_PATH:-"/var/log"}
    LOCAL_LOG_NAME="${3:-null}" && [[ "$LOCAL_LOG_NAME" == null ]] && LOCAL_LOG_NAME=${BASESCRIPT_LOG_FILE_NAME:-basescript.log}
    LOCAL_TIMESTAMP_FLAG="${4:-null}" && [[ "$LOCAL_TIMESTAMP_FLAG" == null ]] && LOCAL_TIMESTAMP_FLAG=${BASESCRIPT_LOG_TIMESTAMP_FLAG:-"+%Y-%m-%d %H:%M:%S"}
    LOCAL_ALLOW_RUN_WITH_SUDO="${5:-null}" && [[ "$LOCAL_ALLOW_RUN_WITH_SUDO" == null ]] && LOCAL_ALLOW_RUN_WITH_SUDO=${ALLOW_RUN_WITH_SUDO:-false}
    LOCAL_STOP_EXECUTION_ON_ERROR="${6:-null}" && [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == null ]] && LOCAL_STOP_EXECUTION_ON_ERROR=${STOP_EXECUTION_ON_ERROR:-false} # most other scripts this is set to true

    # Extra parameters
    LOCAL_TIMESTAMP=$(date "$LOCAL_TIMESTAMP_FLAG")
    LOCAL_LOG_FULL_PATH="${LOCAL_LOG_BASE_PATH%/}/$LOCAL_LOG_NAME"

    # Allows 'sudo' to run this function if destination path it's not owned by the current user
    if [[ "$LOCAL_ALLOW_RUN_WITH_SUDO" == true ]]; then
        LOCAL_RUN_WITH_SUDO=sudo
    else
        LOCAL_RUN_WITH_SUDO="" # Set to empty!

        # Check if file exist and users permissions
        if [[ -f ${LOCAL_LOG_FULL_PATH} && ! -w ${LOCAL_LOG_FULL_PATH} ]] || [[ -d ${LOCAL_LOG_BASE_PATH} && ! -w ${LOCAL_LOG_BASE_PATH} ]]; then
            if [[ ! $(declare -F echoerror) == "" ]]; then
                BASESCRIPT_LOG_ALL_ACTIONS=false
                echoerror "You dont have permission to write log at '${LOCAL_LOG_FULL_PATH}' - [${FUNCNAME[0]}]" "${LOCAL_STOP_EXECUTION_ON_ERROR}"
            else
                echo "You dont have permission to write log at '${LOCAL_LOG_FULL_PATH}' - [${FUNCNAME[0]}]"
                [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
            fi
        fi
    fi

    # Execute command or return error
    if ! echo "$LOCAL_TIMESTAMP USER=$USER SCRIPT=$SCRIPT_PATH/$SCRIPT_NAME LOG=$1" | $LOCAL_RUN_WITH_SUDO tee -a "${LOCAL_LOG_FULL_PATH}" >/dev/null 2>&1; then
        if [[ ! $(declare -F echoerror) == "" ]]; then
            BASESCRIPT_LOG_ALL_ACTIONS=false
            echoerror "Logs could not be saved at '${LOCAL_LOG_FULL_PATH}' - [${FUNCNAME[0]}]" "${LOCAL_STOP_EXECUTION_ON_ERROR}"
        else
            echo "Logs could not be saved at '${LOCAL_LOG_FULL_PATH}' - [${FUNCNAME[0]}]"
            [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
        fi
    fi
}

# Implement test case
#BASESCRIPT_LOG_BASE_PATH="/log"
#log $*
