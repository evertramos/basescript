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
# 1. Check if the services on a docker-compose exists in docker
#
# You must/might inform the parameters below:
# 1. The compose file full path string
# 2. [optional] (default: docker-compose.yml) The compose file name
# 3. [optional] (default: 0) The quantity of service that must be checked
# in the compose file. Sometimes you have a service that should not be
# running and you still want to check it precisely
#
#-----------------------------------------------------------------------

docker_compose_check_service_exists()
{
    local LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME LOCAL_RESULTS LOCAL_QTY_SERVICES
    
    LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME=${1:-null}
    LOCAL_DOCKER_COMPOSE_FILE_NAME=${2:-"docker-compose.yml"}
    LOCAL_QTY_SERVICES=${3:-0}

    [[ $LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME == "" || $LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME == null ]] && \
    echoerror "You must inform the docker-compose full file path to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if docker-compose services exists for: '$LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME/$LOCAL_DOCKER_COMPOSE_FILE_NAME'"

    LOCAL_RESULTS=$(docker-compose --file "$LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME/$LOCAL_DOCKER_COMPOSE_FILE_NAME" ps --quiet | wc -l)

    # Check results
    if [[ $LOCAL_RESULTS > $LOCAL_QTY_SERVICES ]]; then
        DOCKER_COMPOSE_SERVICE_EXISTS=true
    else 
        DOCKER_COMPOSE_SERVICE_EXISTS=false
    fi
}
