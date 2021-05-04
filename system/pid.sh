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
# 1. Save and delete pid file
#
# You must/might inform the parameters below:
# 1. Description of the file name that will be created with the
# pid number
# 2. [optional] (default: )
#
#-----------------------------------------------------------------------

# Script to work with PID
system_save_pid() {
    local LOCAL_PID_FILE
    LOCAL_PID_FILE=${1:-$PID_FILE}
    [[ $LOCAL_PID_FILE == "" || $LOCAL_PID_FILE == null ]] && echoerror "You must inform the pid file name to the function: '${FUNCNAME[0]}'"
    echo $$ > $SCRIPT_PATH/$LOCAL_PID_FILE
    trap "system_delete_pid $LOCAL_PID_FILE" EXIT SIGQUIT SIGINT SIGSTOP SIGTERM ERR
}

system_delete_pid() {
    local LOCAL_PID_FILE
    LOCAL_PID_FILE=${1:-$PID_FILE}
    [[ $LOCAL_PID_FILE == "" || $LOCAL_PID_FILE == null ]] && echoerror "You must inform the pid file name to the function: '${FUNCNAME[0]}'"
    rm -f $SCRIPT_PATH/$LOCAL_PID_FILE
    log "End execution $SCRIPT_NAME [PID: $LOCAL_PID_FILE]"
}
