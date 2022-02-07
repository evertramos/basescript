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
# 1. Delete a specific file
#
# You must/might inform the parameters below:
# 1. File to be deleted
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

file_delete_local_file()
{
    local LOCAL_FILE
     
    LOCAL_FILE=${1:-null}

    [[ $LOCAL_FILE == "" ]] && echoerror "You must inform the required argument(s) to the function: \n'${FUNCNAME[0]}' \nplease check the docs."
 
    [[ "$DEBUG" == true ]] && echo "Deleting file '$LOCAL_FILE'"

    # Checkinf the file (-f) validates if trying to delete a folder
    [[ -f $LOCAL_FILE ]] && rm -f $LOCAL_FILE

    return 0
}
