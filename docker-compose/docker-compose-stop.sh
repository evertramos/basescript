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
# Be carefull when editing this file, it is part of a bigger script!
#
# Basescript - https://github.com/evertramos/basescript
#
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# This function has one main objective:
# 1. Stop the docker-compose service
#
# You must inform the parameters below:
# 1. Path where the compose file are located (/path/docker-compose.yml)
# 2. [optional] docker-compose file name (default: docker-compose.yml)
# 4. [optional] .env file name (default: .env)
# 5. [optional] .env file location (default: same location in arg. 1)
#
#-----------------------------------------------------------------------

docker_compose_stop()
{
    local LOCAL_DOCKER_COMPOSE_PATH LOCAL_DOCKER_COMPOSE_FILE_NAME LOCAL_DOCKER_COMPOSE_ENV_FILE LOCAL_DOCKER_COMPOSE_ENV_PATH LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME LOCAL_DOCKER_COMPOSE_ENV_FULL_FILE

    LOCAL_DOCKER_COMPOSE_PATH=${1:-null}
    LOCAL_DOCKER_COMPOSE_FILE_NAME=${2:-"docker-compose.yml"}
    LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME="${LOCAL_DOCKER_COMPOSE_PATH%/}/$LOCAL_DOCKER_COMPOSE_FILE_NAME"
    LOCAL_DOCKER_COMPOSE_ENV_FILE=${3:-".env"}
    LOCAL_DOCKER_COMPOSE_ENV_PATH=${4:-$LOCAL_DOCKER_COMPOSE_PATH}
    LOCAL_DOCKER_COMPOSE_ENV_FULL_FILE="${LOCAL_DOCKER_COMPOSE_ENV_PATH%/}/$LOCAL_DOCKER_COMPOSE_ENV_FILE"
   
    [[ $LOCAL_DOCKER_COMPOSE_PATH == "" ]] && echoerr "You must inform the docker-compose file path to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Stopping docker composer service for '$LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME' - [function: ${FUNCNAME[0]}]"
   
    # Stop service or return error variable
    if ! docker-compose --env-file $LOCAL_DOCKER_COMPOSE_ENV_FULL_FILE --file $LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME down; then
        ERROR_DOCKER_COMPOSE_START=true
    fi
}

