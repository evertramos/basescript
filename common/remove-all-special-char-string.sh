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
# 1. Remove Dot (.) and Slash (/) from String
#
# You must/might inform the parameters below:
# 1. The string which will be removed the special chars
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

remove_all_special_char_string()
{
    local LOCAL_STRING
    
    LOCAL_STRING=${1:-null}

    [[ $LOCAL_STRING == "" || $LOCAL_STRING == null ]] && echoerr "You must inform an argument to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Removing special characters from '$LOCAL_STRING'"

    REMOVE_ALL_SPECIAL_CHAR_STRING_RESPONSE=$(echo $LOCAL_STRING | tr -d ' ./' | tr -dc '[:alnum:].' | tr '[:upper:]' '[:lower:]' | tr -d '[:cntrl:]')

    return 0
}
