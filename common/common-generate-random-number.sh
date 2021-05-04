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
# 1. Generate a random string
#
# You must/might inform the parameters below:
# 1. [optional] (default: 5) The string size that should be generated
#
#-----------------------------------------------------------------------

common_generate_random_string()
{
    local LOCAL_SIZE

    LOCAL_SIZE=${1:-5}

    [[ "$DEBUG" == true ]] && echo "Generating a random string with "$LOCAL_SIZE" characher(s)"

    # bash generate random string alphanumeric string (upper and lowercase) and
    RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $LOCAL_SIZE | head -n 1)

    if [[ "$RANDOM_STRING" == "" ]]; then
        echoerror "Error generating a random string. Please check the function 'common_generate_random_string'."
        return 1
    else
        return 0
    fi
}
