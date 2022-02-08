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
# 1. Backup a folder and compress file with tar and gzip
#
# You must/might inform the parameters below:
# 1. The full path folder to backup
# 2. The full path folder where backup file should be placed
# 3. [optional] (default: timestamp) A flag to be added to the backup file name
# 4. [optional] (default: null) The backup file name
# 5. [optional] (default: true) If backup file exist replace the old file
# 6. [optional] (default: true) Stop execution on error
#
#-----------------------------------------------------------------------

backup_compress_folder()
{
    local LOCAL_BACKUP_FOLDER_FROM LOCAL_BACKUP_FOLDER_TO LOCAL_DATE_TIME LOCAL_BACKUP_FLAG LOCAL_BACKUP_FILE_NAME LOCAL_BACKUP_FOLDER_NAME LOCAL_REPLACE_BACKUP_FILE LOCAL_STOP_EXECUTION_ON_ERROR

    LOCAL_BACKUP_FOLDER_FROM=${1:-null}
    LOCAL_BACKUP_FOLDER_TO=${2:-null}
    LOCAL_DATE_TIME=$(date "+%Y%m%d_%H%M%S")
    LOCAL_BACKUP_FLAG=${3:-$LOCAL_DATE_TIME}
    LOCAL_BACKUP_FILE_NAME=${4:-null}
    LOCAL_REPLACE_BACKUP_FILE=${5:-true}
    LOCAL_STOP_EXECUTION_ON_ERROR=${6:-true}

    if [[ $LOCAL_BACKUP_FOLDER_TO == "" || $LOCAL_BACKUP_FOLDER_TO == null ]]; then
        if [[ ! $(declare -F echoerror) == "" ]]; then
            echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'" ${LOCAL_STOP_EXECUTION_ON_ERROR}
        else
            echo "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"
            [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
        fi
    fi

    if [[ "$DEBUG" == true ]]; then
        if [[ ! $(declare -F echowarning) == "" ]]; then
            echowarning "Backing up folder '${LOCAL_BACKUP_FOLDER_FROM}' to '${LOCAL_BACKUP_FOLDER_TO}' [flag:${LOCAL_BACKUP_FLAG}] - [function: ${FUNCNAME[0]}]"
        else
            echo "Backing up folder '${LOCAL_BACKUP_FOLDER_FROM}' to '${LOCAL_BACKUP_FOLDER_TO}' [flag:${LOCAL_BACKUP_FLAG}] - [function: ${FUNCNAME[0]}]"
        fi
    fi

    # Verify if folders exists (from and to)
    if [[ ! -d "$LOCAL_BACKUP_FOLDER_FROM" ]]; then
        if [[ ! $(declare -F echoerror) == "" ]]; then
            echoerror "The folder you are trying to backup could not be reached '${LOCAL_BACKUP_FOLDER_FROM}' - [function: ${FUNCNAME[0]}]" ${LOCAL_STOP_EXECUTION_ON_ERROR}
        else
            echo "The folder you are trying to backup could not be reached '${LOCAL_BACKUP_FOLDER_FROM}' - [function: ${FUNCNAME[0]}]"
            [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
        fi
    fi
    if [[ ! -d "$LOCAL_BACKUP_FOLDER_TO" ]]; then
        if [[ ! $(declare -F echoerror) == "" ]]; then
            echoerror "The folder you are trying to save the backup is not reachable '${LOCAL_BACKUP_FOLDER_TO}' - [function: ${FUNCNAME[0]}]" ${LOCAL_STOP_EXECUTION_ON_ERROR}
        else
            echo "The folder you are trying to save the backup is not reachable '${LOCAL_BACKUP_FOLDER_TO}' - [function: ${FUNCNAME[0]}]"
            [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
        fi
    fi

    # Prepare backup file name if is not set
    if [[ $LOCAL_BACKUP_FILE_NAME == "" || $LOCAL_BACKUP_FILE_NAME == null ]]; then
        LOCAL_BACKUP_FILE_NAME=$(basename $LOCAL_BACKUP_FOLDER_FROM | tr -dc '[:alnum:].' | tr '[:upper:]' '[:lower:]' | tr -d '[:cntrl:]')
    fi

    # Add file flag exist
    if [[ ! $LOCAL_BACKUP_FLAG == "" && ! $LOCAL_BACKUP_FLAG == null ]]; then
        LOCAL_BACKUP_FILE_NAME="${LOCAL_BACKUP_FILE_NAME}-${LOCAL_BACKUP_FLAG}"
    fi

    # Add file extension
    LOCAL_BACKUP_FILE_NAME="${LOCAL_BACKUP_FILE_NAME}.tar.gz"

    # Check if file already exist in the destination folder
    if [[ -f "${LOCAL_BACKUP_FOLDER_TO}/${LOCAL_BACKUP_FILE_NAME}" && ! "$LOCAL_REPLACE_BACKUP_FILE" == true ]]; then
        if [[ ! $(declare -F echoerror) == "" ]]; then
            echoerror "The backup file already exist at '${LOCAL_BACKUP_FOLDER_TO}/${LOCAL_BACKUP_FILE_NAME}' - [function: ${FUNCNAME[0]}]" ${LOCAL_STOP_EXECUTION_ON_ERROR}
        else
            echo "The backup file already exist at '${LOCAL_BACKUP_FOLDER_TO}/${LOCAL_BACKUP_FILE_NAME}' - [function: ${FUNCNAME[0]}]"
            [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
        fi
    fi

    # Get the last folder name so we can backup with this folder in tar file
    LOCAL_BACKUP_FOLDER_NAME=$(basename $LOCAL_BACKUP_FOLDER_FROM)

    if ! sudo tar -czf "${LOCAL_BACKUP_FOLDER_TO}/${LOCAL_BACKUP_FILE_NAME}" -C "${LOCAL_BACKUP_FOLDER_FROM%//}/../" $LOCAL_BACKUP_FOLDER_NAME; then
        BACKUP_COMPRESS_FOLDER_ERROR=true
    else
        BACKUP_COMPRESS_FOLDER_FULLFILE="${LOCAL_BACKUP_FOLDER_TO}/${LOCAL_BACKUP_FILE_NAME}"
    fi
}

# @todo - implement test cases
#backup_compress_folder "$@"

