# This file is part of a bigger script!
#
# Be carefull when editing it

# ----------------------------------------------------------------------
#   
# Developed by
#   Evert Ramos <evert.ramos@gmail.com>     
#
# Copyright Evert Ramos
#
# ----------------------------------------------------------------------

# Function/Script to get/download backup file to ftp server
ftp_get_file_ftp()
{
    local LOCAL_FILE_NAME LOCAL_SERVER_NAME LOCAL_SERVER_DESTINATION LOCAL_RESTORE_TEMP_FOLDER
    
    LOCAL_FILE_NAME=${1:-null}
    LOCAL_SERVER_NAME=${2:-null}
    LOCAL_SERVER_DESTINATION=${3%/:-null}
    LOCAL_RESTORE_TEMP_FOLDER=${4%/:-null}

    [[ $LOCAL_RESTORE_TEMP_FOLDER == "" ]] && echoerr "You must inform all arguments to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Downloading file '$LOCAL_FILE_NAME' from ftp server '$LOCAL_SERVER_NAME' to location '$LOCAL_RESTORE_TEMP_FOLDER'."

    cd $LOCAL_RESTORE_TEMP_FOLDER
    echo -e "get ${LOCAL_SERVER_DESTINATION%/}/$LOCAL_FILE_NAME" | sftp $LOCAL_SERVER_NAME
    cd - > /dev/null 2>&1
}

