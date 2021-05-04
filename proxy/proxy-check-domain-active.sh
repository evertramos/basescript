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
# 1. Check if an URL is active in the local proxy
#
# You must/might inform the parameters below:
# 1. Domain name (domain.com)
# 2. [optional] (default: 'nginx-proxy') The proxy option you are
# running in the server
#
#-----------------------------------------------------------------------

proxy_check_url_active()
{
    local LOCAL_URL LOCAL_PROXY_SERVICE
     
    LOCAL_URL=${1:-null}
    LOCAL_PROXY_SERVICE=${2:-"nginx-proxy"}

    [[ $LOCAL_URL == "" || $LOCAL_URL == null ]] && echoerror "You must inform an URL to the function '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if the URL '$LOCAL_URL' is running in the Proxy."

    if [[ $LOCAL_PROXY_SERVICE == "nginx-proxy" ]]; then
        # nginx-proxy
        LOCAL_CHECK_URL_ACTIVE_PROXY=$(cat $PROXY_FOLDER/data/conf.d/default.conf | grep "upstream $LOCAL_URL" | wc -l)
    else
        echoerror "The proxy service '$LOCAL_PROXY_SERVICE' is not supported by this function [${FUNCNAME[0]}]"
    fi

    if [[ $LOCAL_CHECK_URL_ACTIVE_PROXY > 0 ]]; then
        DOMAIN_ACTIVE_IN_PROXY=true
    else
        DOMAIN_ACTIVE_IN_PROXY=false
    fi

    return 0
}
