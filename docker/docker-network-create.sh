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
# 1. Create a network in local docker
#
# You must/might inform the parameters below:
# 1. Network name which should be created
# 2. [optional] (default: ) Subnet for the IPV4
#   - You can set 'false' or send an empty string to this option if
#   only wants to activate IPv6
# 3. [optional] (default: false) Set 'true' if IPv6 should be enabled
# 4. [optional] (default: ) Subnet for the IPV6
# in the network options
#
#-----------------------------------------------------------------------

docker_network_create()
{
    local LOCAL_NETWORK_NAME LOCAL_ENABLE_IPv4 LOCAL_ENABLE_IPv6 LOCAL_RESULT
    
    LOCAL_NETWORK_NAME=${1:-null}
    LOCAL_IPv4_SUBNET=${2:-null}
    LOCAL_ENABLE_IPv6=${3:-false}
    LOCAL_IPv6_SUBNET=${4:-"2001:db8:1:1::/112"}
    LOCAL_IPv4_DEFAULT="172.172.0.0/16" # This will be used in case of error when creating a docker network

    [[ $LOCAL_NETWORK_NAME == "" || $LOCAL_NETWORK_NAME == null ]] && echoerror "You must inform the network name to the function: '${FUNCNAME[0]}'"

    [[ "$LOCAL_ENABLE_IPv6" == true ]] && [[ $LOCAL_IPv6_SUBNET == "" || $LOCAL_IPv6_SUBNET == null ]] && echoerror "You must inform the network subnet for ipv6"

    [[ "$DEBUG" == true ]] && echo "Creating the network '$LOCAL_NETWORK_NAME' in this server."

    # Create docker network
    if [[ "$LOCAL_ENABLE_IPv6" == true ]]; then
        if [[ $LOCAL_IPv4_SUBNET == "" || $LOCAL_IPv4_SUBNET == null || $LOCAL_IPv4_SUBNET == false ]]; then
            docker network create $LOCAL_NETWORK_NAME --ipv6 --subnet=$LOCAL_IPv6_SUBNET && return
            docker network create $LOCAL_NETWORK_NAME --ipv6 --subnet=$LOCAL_IPv6_SUBNET --subnet=$LOCAL_IPv4_DEFAULT && return
        else
            docker network create $LOCAL_NETWORK_NAME --ipv6 --subnet=$LOCAL_IPv6_SUBNET --subnet=$LOCAL_IPv4_SUBNET && return
        fi
    else
        if [[ $LOCAL_IPv4_SUBNET == "" || $LOCAL_IPv4_SUBNET == null || $LOCAL_IPv4_SUBNET == false ]]; then
            docker network create $LOCAL_NETWORK_NAME && return
            docker network create $LOCAL_NETWORK_NAME --subnet=$LOCAL_IPv4_DEFAULT && return
        else
            docker network create $LOCAL_NETWORK_NAME --subnet=$LOCAL_IPv4_SUBNET && return
        fi
    fi

    ERROR_DOCKER_NETWORK_CREATE=true
    return
}
