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
# 1. Remove dot (.) and slash (/) from a string
#
# You must/might inform the parameters below:
# 1. String that will be analized
# 2. [optional] (default: )
#
#-----------------------------------------------------------------------
string_remove_dot_slash_from_string()
{
    local LOCAL_STRING
    
    LOCAL_STRING=${1:-null}

    [[ $LOCAL_STRING == "" || $LOCAL_STRING == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Removing dots (.) and slashes (/) from '$LOCAL_STRING'"

    STRING_REMOVE_DOT_SLASH_FROM_STRING_RESPONSE=$(echo $LOCAL_STRING | tr -d ' ./' | tr '[:upper:]' '[:lower:]' | tr -d '[:cntrl:]')

    return 0
}

