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
# 1. Check if a single container is running in local docker
#
# You must/might inform the parameters below:
# 1. Cotnainer name
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

docker_check_container_is_running()
{
    local LOCAL_CONTAINER_NAME LOCAL_RESULT
    
    LOCAL_CONTAINER_NAME=${1:-null}

    [[ $LOCAL_CONTAINER_NAME == ""  || $LOCAL_CONTAINER_NAME == null ]] && echoerr "You must inform the container name to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if the container '$LOCAL_CONTAINER_NAME' exist in this server."

    LOCAL_RESULTS=$(docker ps --quiet --filter name=$LOCAL_CONTAINER_NAME | wc -l)

    # Check results
    if [[ $LOCAL_RESULTS > 0 ]]; then
        CONTAINER_EXISTS=true
    else 
        CONTAINER_EXISTS=false
    fi
}
