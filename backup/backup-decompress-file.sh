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
# 1. Decompress a backup file
#
# You must/might inform the parameters below:
# 1. Destination folder where the file will be decompresses
# 2. Compressed file name including the full path
# 3. [optional] (default: true) Run as sudo
#
#-----------------------------------------------------------------------

backup_decompress_file()
{

    local LOCAL_DESTINATION_FOLDER LOCAL_BACKUP_FULL_FILE 
    
    LOCAL_DESTINATION_FOLDER=${1:-null}
    LOCAL_BACKUP_FULL_FILE=${2:-null}
    RUN_WITH_SUDO=${3:-true}

    [[ $LOCAL_DESTINATION_FOLDER == "" || $LOCAL_DESTINATION_FOLDER == null ]] || [[ $LOCAL_BACKUP_FULL_FILE == "" || $LOCAL_BACKUP_FULL_FILE == null ]] && echoerror "You must inform DESTINATION and FULLFILE NAME to the function: \n'${FUNCNAME[0]}' \nplease check the docs."

    run_function system_check_package_installed "tar" true
    run_function system_check_package_installed "gzip" true
    
    [[ "$DEBUG" == true ]] && echo "Decompressing file '$LOCAL_BACKUP_FULL_FILE' to '$LOCAL_DESTINATION_FOLDER'."

    cd $LOCAL_DESTINATION_FOLDER 

    if [[ "$DEBUG" != true ]]; then
        if [[ "$RUN_WITH_SUDO" == true ]]; then
            sudo tar -xzf $LOCAL_BACKUP_FULL_FILE
        else
            tar -xzf $LOCAL_BACKUP_FULL_FILE
        fi
    else
        if [[ "$RUN_WITH_SUDO" == true ]]; then
            sudo tar --verbose -xzf $LOCAL_BACKUP_FULL_FILE
        else
            tar --verbose -xzf $LOCAL_BACKUP_FULL_FILE
        fi
    fi
    cd - > /dev/null 2>&1
}

