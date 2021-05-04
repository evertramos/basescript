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
# 1. Update specific string in docker-compose file
#
# You must/might inform the parameters below:
# 1. Path where the compose file are located (/path/docker-compose.yml)
# 2. String that should be REPLACED
# 3. New String
# 4. [optional] docker-compose file name (default: docker-compose.yml)
#
#-----------------------------------------------------------------------

docker_compose_replace_string()
{
    local LOCAL_DOCKER_COMPOSE_PATH LOCAL_REPLACE_STRING_FROM LOCAL_REPLACE_STRING_TO LOCAL_DOCKER_COMPOSE_FILE_NAME LOCAL_CONTAINER_DB LOCAL_CONTAINER_WP

    LOCAL_DOCKER_COMPOSE_PATH=${1:-null}
    LOCAL_REPLACE_STRING_FROM=${2:-null}
    LOCAL_REPLACE_STRING_TO=${3:-false}
    LOCAL_DOCKER_COMPOSE_FILE_NAME=${4:-"docker-compose.yml"}
    LOCAL_DOCKER_COMPOSE_FULL_FILE_PATH="${LOCAL_DOCKER_COMPOSE_PATH%/}/$LOCAL_DOCKER_COMPOSE_FILE_NAME"

    [[ $LOCAL_REPLACE_STRING_TO == "" || $LOCAL_REPLACE_STRING_TO == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    # Check if file exists
    [[ "$DEBUG" == true ]] && echo "Updating in file '$LOCAL_DOCKER_COMPOSE_FULL_FILE_PATH' the string from: '$LOCAL_REPLACE_STRING_FROM' to: '$LOCAL_REPLACE_STRING_TO' - [function: ${FUNCNAME[0]}]"
   
    # Update the docker-compose file
    file_update_file $LOCAL_DOCKER_COMPOSE_FULL_FILE_PATH $LOCAL_REPLACE_STRING_FROM $LOCAL_REPLACE_STRING_TO
}
