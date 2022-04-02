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
# 1. Create a folder in ftp server
#
# You must/might inform the parameters below:
# 1.
# 2.
# 3. [optional] (default: )
#
#-----------------------------------------------------------------------

# @todo - update this function to the new standards with optionals and function validation

ftp_create_folders_ftp()
{
    local LOCAL_SERVER_NAME LOCAL_SERVER_DESTINATION LOCAL_QTY_FOLDERS LOCAL_NUMBER_REGEX LOCAL_FOLDER_CREATE LOCAL_MKDIR_COMMAND
    
    LOCAL_SERVER_NAME=${1:-null}
    LOCAL_SERVER_DESTINATION=${2:-null}

    [[ $LOCAL_SERVER_DESTINATION == "" ]] && echoerror "You must inform all arguments to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Creating the folder '$LOCAL_SERVER_DESTINATION' in ftp server '$LOCAL_SERVER_NAME'."

    # Create folders inside the ftp server
    LOCAL_QTY_FOLDERS=$(echo $LOCAL_SERVER_DESTINATION | awk -F "/" '{print NF-2}')

    # Verify if LOCAL_QTY_FOLDERS is a number    
    LOCAL_NUMBER_REGEX='^[0-9]+$'
    if ! [[ $LOCAL_QTY_FOLDERS =~ $LOCAL_NUMBER_REGEX ]]; then
        echowarning "There was some errors when creating ftp folders '$LOCAL_SERVER_DESTINATION' at '$LOCAL_SERVER_NAME' - function '${FUNCNAME[0]}'."
        return 0
    fi

    # Clean up folder to create
    LOCAL_FOLDER_CREATE=""
    for (( i=1; i<=$LOCAL_QTY_FOLDERS; i++ )); do
        LOCAL_NUM=1
        if [[ $i == 1 ]]; then
            LOCAL_FOLDER_CREATE=$(echo $LOCAL_SERVER_DESTINATION | awk -v num=$((i + LOCAL_NUM)) -F"/" '{print $num}')
            LOCAL_MKDIR_COMMAND="mkdir $LOCAL_FOLDER_CREATE"
        else
            LOCAL_FOLDER_CREATE=$LOCAL_FOLDER_CREATE"/"$(echo $LOCAL_SERVER_DESTINATION | awk -v num=$((i + LOCAL_NUM)) -F"/" '{print $num}')
            LOCAL_MKDIR_COMMAND="$LOCAL_MKDIR_COMMAND \n mkdir $LOCAL_FOLDER_CREATE"
        fi
   
        [[ $i == $LOCAL_QTY_FOLDERS ]] && echo -e $LOCAL_MKDIR_COMMAND | sftp $LOCAL_SERVER_NAME  > /dev/null 2>&1
        #echo -e "mkdir $LOCAL_FOLDER_CREATE" | sftp $LOCAL_SERVER_NAME
    done 
}

#source ../messages/message-echoout.sh