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
# 1. Start the docker-compose service
#
# You must/might inform the parameters below:
# 1. Path where the compose file are located (/path/docker-compose.yml)
# 2. [optional] (default: false) pull docker-compose images before start
# 3. [optional] (default: docker-compose.yml) docker-compose file name
# 4. [optional] (default: .env) .env file name
# 5. [optional] (default: same location in arg. 1) .env file location
#
#-----------------------------------------------------------------------

docker_compose_start()
{
    local LOCAL_DOCKER_COMPOSE_PATH LOCAL_PULL_BEFORE_START LOCAL_DOCKER_COMPOSE_FILE_NAME LOCAL_DOCKER_COMPOSE_ENV_FILE LOCAL_DOCKER_COMPOSE_ENV_PATH LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME LOCAL_DOCKER_COMPOSE_ENV_FULL_FILE

    LOCAL_DOCKER_COMPOSE_PATH=${1:-null}
    LOCAL_PULL_BEFORE_START=${2:-false}
    LOCAL_DOCKER_COMPOSE_FILE_NAME=${3:-"docker-compose.yml"}
    LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME="${LOCAL_DOCKER_COMPOSE_PATH%/}/$LOCAL_DOCKER_COMPOSE_FILE_NAME"
    LOCAL_DOCKER_COMPOSE_ENV_FILE=${4:-".env"}
    LOCAL_DOCKER_COMPOSE_ENV_PATH=${5:-$LOCAL_DOCKER_COMPOSE_PATH}
    LOCAL_DOCKER_COMPOSE_ENV_FULL_FILE="${LOCAL_DOCKER_COMPOSE_ENV_PATH%/}/$LOCAL_DOCKER_COMPOSE_ENV_FILE"
   
    [[ $LOCAL_DOCKER_COMPOSE_PATH == "" || $LOCAL_DOCKER_COMPOSE_PATH == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Starting docker composer service for '$LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME' - [function: ${FUNCNAME[0]}]"
   
    # Pull if set 
    [[ "$LOCAL_PULL_BEFORE_START" == true ]] && docker-compose --env-file $LOCAL_DOCKER_COMPOSE_ENV_FULL_FILE --file $LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME pull

    # Start service
    if ! docker-compose --env-file $LOCAL_DOCKER_COMPOSE_ENV_FULL_FILE --file $LOCAL_DOCKER_COMPOSE_FULL_FILE_NAME up -d; then
        ERROR_DOCKER_COMPOSE_START=true
    fi
}
