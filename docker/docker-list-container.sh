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
# 1. List all containers running (with filter)
#
# You must/might inform the parameters below:
# 1. [optional] String to filter the containers' list (default: )
#
#-----------------------------------------------------------------------

docker_list_container()
{
    local LOCAL_FILTER_STRING

    LOCAL_FILTER_STRING=${1:-null}

    [[ "$DEBUG" == true ]] && echo "Listing all contianers with '$LOCAL_FILTER_STRING' extension."

    if [[ ! "$LOCAL_FILTER_STRING" == null ]]; then
        DOCKER_LIST_CONTAINER_RESPONSE=($(docker ps --filter name="$LOCAL_FILTER_STRING" --format "{{.Names}}"))
    else
        DOCKER_LIST_CONTAINER_RESPONSE=($(docker ps --format "{{.Names}}"))
    fi

    return 0
}

