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
# 1. Remove a network in local docker
#
# You must/might inform the parameters below:
# 1. Network name which should be created
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

docker_network_remove()
{
    local LOCAL_NETWORK_NAME LOCAL_ENABLE_IPv6 LOCAL_RESULT
    
    LOCAL_NETWORK_NAME=${1:-null}

    [[ $LOCAL_NETWORK_NAME == "" || $LOCAL_NETWORK_NAME == null ]] && echoerror "You must inform the network name to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Removing the network '$LOCAL_NETWORK_NAME' in this server."

    # Delete docker network
    if ! docker netowrk rm $LOCAL_NETWORK_NAME; then
        ERROR_DOCKER_NETWORK_CREATE=true
    fi
}
