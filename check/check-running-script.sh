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
# 1. Check if there is another instance of the script running
#
# You must/might inform the parameters below:
# 1. Pid file name
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

check_running_script()
{
    local LOCAL_PID_FILE
    
    LOCAL_PID_FILE=${1:-$PID_FILE}
    PID=$SCRIPT_PATH/$LOCAL_PID_FILE

    [[ "$DEBUG" == true ]] && echo "Checking if there is another instance of the script running..." && echo "pid: "$PID

    if [[ -e "$PID" ]]; then
        MESSAGE="Script already running."
        return 1
    fi
}
