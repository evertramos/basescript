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
# 1. Check if a package is installed in a container using ps (procps)
#
# You must/might inform the parameters below:
# 1. Container that will be check if service is running
# 3. Service name
# 2. [optional] (default: )
#
#-----------------------------------------------------------------------

docker_check_service_is_running_with_procps()
{
    local LOCAL_CONTAINER LOCAL_SERVICE_NAME LOCAL_RESULT

    LOCAL_CONTAINER="${1:-null}"
    LOCAL_SERVICE_NAME="${2:-null}"

    [[ $LOCAL_SERVICE_NAME == "" || $LOCAL_SERVICE_NAME == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if service '$LOCAL_SERVICE_NAME' is running in the container '$LOCAL_CONTAINER'"

    LOCAL_RESULT=$(docker exec -it $LOCAL_CONTAINER ps aux | grep $LOCAL_SERVICE_NAME | wc -l)

    if [[ $LOCAL_RESULT > 0 ]]; then
        [[ "$DEBUG" == true ]] && echo "Service '$LOCAL_SERVICE_NAME' is running in the container '$LOCAL_CONTAINER'!"
        DOCKER_SERVICE_IS_RUNNING=true
    else
        [[ "$DEBUG" == true ]] && echo "Service '$LOCAL_SERVICE_NAME' is NOT running in the container '$LOCAL_CONTAINER'!"
        DOCKER_SERVICE_IS_RUNNING=false
    fi

    return 0
}

