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

# Function/Script to check if file exists in ftp server
ftp_check_file_exists_ftp()
{
    local LOCAL_SERVER_NAME LOCAL_FILE_NAME
    
    LOCAL_SERVER_NAME=${1:-null}
    LOCAL_FILE_NAME=${2:-null}

    [[ $LOCAL_FILE_NAME == "" ]] && echoerr "You must inform all arguments to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if file '$LOCAL_FILE_NAME' in ftp server '$LOCAL_SERVER_NAME'."

    #echo "df -h $LOCAL_FILE_NAME" | sftp $LOCAL_SERVER_NAME
    LOCAL_RESULT="$(echo "df jose.tar.gz" | sftp $LOCAL_SERVER_NAME)"
    echo "result: "$LOCAL_RESULT
    if [ $? -eq 0 ]
    then
        echo "File exists"
    else
        echo "File does not exist"
    fi

    return 0
}

