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
# 1.
# 2. [optional] (default: false)
#
#-----------------------------------------------------------------------

log()
{
    local LOCAL_LOG_BASE_PATH LOCAL_LOG_NAME LOCAL_TIMESTAMP_FLAG LOCAL_TIMESTAMP LOCAL_LOG_FULL_PATH

    LOCAL_LOG_BASE_PATH=${BASESCRIPT_LOG_BASE_PATH:-"/var/log"}
    LOCAL_LOG_NAME=${BASESCRIPT_LOG_FILE_NAME:-basescript.log}
    LOCAL_TIMESTAMP_FLAG=${BASESCRIPT_LOG_TIMESTAMP_FLAG:-"+%Y-%m-%d %H:%M:%S"}

    LOCAL_TIMESTAMP=$(date "$LOCAL_TIMESTAMP_FLAG")
    LOCAL_LOG_FULL_PATH="${LOCAL_LOG_BASE_PATH%/}/$LOCAL_LOG_NAME"

    echo "$LOCAL_TIMESTAMP USER=$USER SCRIPT=$SCRIPT_PATH/$SCRIPT_NAME LOG='"$@"'" | sudo tee -a $LOCAL_LOG_FULL_PATH
}

