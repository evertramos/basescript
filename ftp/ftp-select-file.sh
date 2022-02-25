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

# Script to list all files in a specific folder in a ftp server and filter if has a filter
ftp_select_file() 
{
    local LOCAL_SERVER_NAME LOCAL_SERVER_PATH LOCAL_FILTER LOCAL_FILES_OPTIONS

    LOCAL_SERVER_NAME=${1:-null}
    LOCAL_SERVER_PATH=${2}
    LOCAL_FILTER="${3}"
    
    [[ $LOCAL_SERVER_PATH == "" ]] && echoerr "You must inform a path to list the files in function: '${FUNCNAME[0]}'"
    #[[ $LOCAL_FILTER == "" ]] && echoerr "You must inform a filter to select files from a ftp server - function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Listing all files in directory: '$LOCAL_SERVER_PATH'."

    #echosuccess $(echo -e "cd $LOCAL_SERVER_PATH \n ls" | sftp $LOCAL_SERVER_NAME | awk '{print $NF}' | grep -v "ls" | grep -v "$LOCAL_SERVER_PATH" | wc -l)

    if [[ $LOCAL_FILTER != "" ]]; then 
        LOCAL_FILES_OPTIONS=($(echo -e "cd $LOCAL_SERVER_PATH \n ls" | sftp $LOCAL_SERVER_NAME | awk '{print $NF}' | grep -v "ls" | grep -v "$LOCAL_SERVER_PATH" | grep $ARG_FILTER))
    else
        LOCAL_FILES_OPTIONS=($(echo -e "cd $LOCAL_SERVER_PATH \n ls" | sftp $LOCAL_SERVER_NAME | awk '{print $NF}' | grep -v "ls" | grep -v "$LOCAL_SERVER_PATH"))

        [[ ${#LOCAL_FILES_OPTIONS[@]} > 20 ]] && echoerr "The list of files you are trying to list is too big for this terminal, please user the filter option (--filter=NAME)"
    fi

    echo "${blue}-----------------------------------------------------${reset}"
    echo 
    echo "${blue}Select one of the files below:" 
    echo 

    # Call external funcion to select option
    select_option "${LOCAL_FILES_OPTIONS[@]}"
    SELECTED_FILE_INDEX=$?
    SELECTED_FILE_NAME=${LOCAL_FILES_OPTIONS[$SELECTED_FILE_INDEX]}
    echo "${blue}You have selected the file: "$SELECTED_FILE_NAME
    echo 
    echo "${blue}-----------------------------------------------------${reset}"
}
