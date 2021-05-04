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
# 1. Check the integrity of the informed tar file
#
# You must/might inform the parameters below:
# 1. The file name including the full path
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

backup_check_tar_file_integrity()
{
    local LOCAL_FULLFILE_NAME LOCAL_RESULT
     
    LOCAL_FULLFILE_NAME=${1:-null}
 
    [[ $LOCAL_FULLFILE_NAME == "" || $LOCAL_FULLFILE_NAME == null ]] && echoerror "You must inform the required argument(s) to the function: \n'${FUNCNAME[0]}' \nplease check the docs."
 
    [[ "$DEBUG" == true ]] && echo "Checking file's integrity: '$LOCAL_FULLFILE_NAME'"
    
    LOCAL_RESULT=$(tar tf $LOCAL_FULLFILE_NAME &> /dev/null || echo 1)

    [[ $LOCAL_RESULT == 1 ]] && echoerror "The file informed is currupted or was not found: \n'$LOCAL_FULLFILE_NAME' \nplease check and try again."

    return 0 
}
