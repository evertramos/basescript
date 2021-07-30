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
# 1. Start a service inside a container
#
# You must/might inform the parameters below:
# 1. Container where the service should start
# 2. [optional] (default: )
#
#-----------------------------------------------------------------------

docker_start_service_with_service()
{
    local LOCAL_CONTAINER LOCAL_SERVICE_NAME LOCAL_RESULT

    LOCAL_CONTAINER="${1:-null}"
    LOCAL_SERVICE_NAME="${2:-null}"

    [[ $LOCAL_SERVICE_NAME == "" || $LOCAL_SERVICE_NAME == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Starting '$LOCAL_SERVICE_NAME' service in container '$LOCAL_CONTAINER'"

    docker exec -it $LOCAL_CONTAINER service "$LOCAL_SERVICE_NAME" start

    return 0
}

