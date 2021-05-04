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
# 1. Check if container exists in local environment
#
# You must/might inform the parameters below:
# 1. Container name
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

check_container_exists()
{
    local LOCAL_CONTAINER_NAME

    LOCAL_CONTAINER_NAME="${1:-null}"

    [[ $LOCAL_CONTAINER_NAME == "" || $LOCAL_CONTAINER_NAME == null ]] && echoerror "You must inform a container name to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if the container '"$LOCAL_CONTAINER_NAME"' is exists"

    # Check results
    if [[ ! "$(docker ps -a -q -f name=$LOCAL_CONTAINER_NAME)" ]]; then
        CONTAINER_EXISTS=false
    else
        CONTAINER_EXISTS=true
    fi 
}
