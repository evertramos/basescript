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
# 1. Check if the IPv6 is a valid address
#
# You must/might inform the parameters below:
# 1. IP address that should be checked
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

ip_check_ipv6()
{
    local LOCAL_IP_ADDRESS

    LOCAL_IP_ADDRESS=${1:-null}

    # Check required
    [[ $LOCAL_IP_ADDRESS == "" || $LOCAL_IP_ADDRESS == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    if [[ $LOCAL_IP_ADDRESS =~ ^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$ ]]; then
        IP_IPV6=true
    else
        IP_IPV6=false
    fi
}
