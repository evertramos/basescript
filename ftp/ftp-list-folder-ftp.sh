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

# Function/Script to list a folder in the ftp server
ftp_list_folder_ftp()
{
    local LOCAL_FOLDER_NAME LOCAL_SERVER_NAME 
    
    LOCAL_FOLDER_NAME=${1:-null}
    LOCAL_SERVER_NAME=${2:-null}

    [[ $LOCAL_SERVER_NAME == "" ]] && echoerr "You must inform all arguments to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Listint folder '$LOCAL_FOLDER_NAME' on ftp server '$LOCAL_SERVER_NAME'."

    echo "${blue}"
    echo "Listing backup folder from FTP Storage (folder '$LOCAL_FOLDER_NAME'):" 
    echo -e "ls -lah $LOCAL_FOLDER_NAME" | sftp $LOCAL_SERVER_NAME
    echo "${reset}"
}

