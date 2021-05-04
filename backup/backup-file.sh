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
# 1. Backup a file
#
# You must/might inform the parameters below:
# 1. Full file path
# 2. [optional] (default: .backup_[CURRENT_DATE]) Extension tag for the
# backup file
#
#-----------------------------------------------------------------------

backup_file()
{
    local LOCAL_FULL_FILE_PATH LOCAL_BACKUP_TAG_STRING

    LOCAL_FULL_FILE_PATH=${1:-null}
    LOCAL_BACKUP_TAG_STRING=${2:-".backup_$(date +'%Y%m%d-%H%M%S')"}

    # Check required 
    [[ $LOCAL_FULL_FILE_PATH == "" || $LOCAL_FULL_FILE_PATH == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    # Debug message
    [[ "$DEBUG" == true ]] && echo "Back up file: '$LOCAL_FULL_FILE_PATH' \nto '$LOCAL_FULL_FILE_PATH$LOCAL_BACKUP_TAG_STRING'."

    cp $LOCAL_FULL_FILE_PATH $LOCAL_FULL_FILE_PATH$LOCAL_BACKUP_TAG_STRING

    BACKUP_FILE=$LOCAL_FULL_FILE_PATH$LOCAL_BACKUP_TAG_STRING
}
