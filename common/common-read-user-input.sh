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
# 1. Read user's input
#
# You must/might inform the parameters below:
# 1. [optional] (default: 'Please enter the required information:') You
# may inform the sentence you want to show to the user for the input
#
#-----------------------------------------------------------------------

common_read_user_input()
{
    local LOCAL_USER_RESPONSE LOCAL_USER_TEXT
    
    LOCAL_USER_TEXT="${1:-Please enter the required information:}"
    
    [[ "$DEBUG" == true ]] && echo "Reading users input ["$LOCAL_USER_TEXT"]"

    printf "${purple} $question question ${reset}${cyan}${LOCAL_USER_TEXT//\\n/\\n   }" 1>&2;
    read LOCAL_USER_RESPONSE
    USER_INPUT_RESPONSE=$LOCAL_USER_RESPONSE
}
