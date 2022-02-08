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
# 1. Send file to ftp server
#
# You must/might inform the parameters below:
# 1. File to be sent - fullfill
# 2. Server string connection (user@host)
# 3. [optional] (default: root folder) Ftp folder name where file will be sent to
# 4. [optional] (default: true) Stop execution on error
#
#-----------------------------------------------------------------------

ftp_send_file_ftp()
{
    local LOCAL_FULLFILE_NAME LOCAL_SERVER_STRING_CONNECTION LOCAL_SERVER_FOLDER_DESTINATION LOCAL_STOP_EXECUTION_ON_ERROR

    LOCAL_FULLFILE_NAME=${1:-null}
    LOCAL_SERVER_STRING_CONNECTION=${2:-null}
    LOCAL_SERVER_FOLDER_DESTINATION=${3:-"."}
    LOCAL_STOP_EXECUTION_ON_ERROR=${4:-true}

    if [[ $LOCAL_SERVER_STRING_CONNECTION == "" || $LOCAL_SERVER_STRING_CONNECTION == null ]]; then
         if [[ ! $(declare -F echoerror) == "" ]]; then
             echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'" ${LOCAL_STOP_EXECUTION_ON_ERROR}
         else
             echo "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"
             [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
         fi
     fi

     if [[ "$DEBUG" == true ]]; then
         if [[ ! $(declare -F echowarning) == "" ]]; then
             echowarning "Sending file '$LOCAL_FULLFILE_NAME' to ftp server '$LOCAL_SERVER_STRING_CONNECTION' to location '$LOCAL_SERVER_FOLDER_DESTINATION'."
         else
             echo "Sending file '$LOCAL_FULLFILE_NAME' to ftp server '$LOCAL_SERVER_STRING_CONNECTION' to location '$LOCAL_SERVER_FOLDER_DESTINATION'."
         fi
     fi

    # If destination folder does not exist, create it in ftp server
    if [[ ! $LOCAL_SERVER_FOLDER_DESTINATION == "." ]]; then
        echo -e "mkdir ${LOCAL_SERVER_FOLDER_DESTINATION}" | sftp $LOCAL_SERVER_STRING_CONNECTION
    fi

    # Send file to ftp server
    echo -e "put $LOCAL_FULLFILE_NAME ${LOCAL_SERVER_FOLDER_DESTINATION}" | sftp $LOCAL_SERVER_STRING_CONNECTION
    if [[ $? -gt 0 ]]; then
       FTP_SEND_FILE_FTP_ERROR=true
    fi
}

# @todo - Implement test cases
#source ftp-create-folders-ftp.sh
#ftp_send_file_ftp "$@"
#echo "Error: ${FTP_SEND_FILE_FTP_ERROR:-false}"