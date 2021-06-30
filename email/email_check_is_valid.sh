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
# 1. Check if there is a valid email address
#
# You must/might inform the parameters below:
# 1. Email address that should be checked
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

email_check_is_valid()
{
    local LOCAL_EMAIL_ADDRESS

    LOCAL_EMAIL_ADDRESS=${1:-null}

    # Check required
    [[ $LOCAL_EMAIL_ADDRESS == "" || $LOCAL_EMAIL_ADDRESS == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    if [[ $LOCAL_EMAIL_ADDRESS =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        EMAIL_IS_VALID=true
    else
        EMAIL_IS_VALID=false
    fi
}
