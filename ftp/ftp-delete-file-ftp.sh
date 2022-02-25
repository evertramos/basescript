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

# Function/Script to delete backup file in ftp server
ftp_delete_file_ftp()
{
    local LOCAL_BACKUP_FULLFILE_PATH LOCAL_SERVER_NAME
    
    LOCAL_BACKUP_FULLFILE_PATH=${1:-null}
    LOCAL_SERVER_NAME=${2:-null}

    [[ $LOCAL_SERVER_NAME == "" ]] && echoerr "You must inform all arguments to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Deleting file '$LOCAL_BACKUP_FULLFILE_PATH' in ftp server '$LOCAL_SERVER_NAME'."

    echo -e "rm $LOCAL_BACKUP_FULLFILE_PATH" | sftp $LOCAL_SERVER_NAME
}

