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
# 1. Check if the informed domain exists in your DNS service
#
# You must/might inform the parameters below:
# 1. Domain name
# 2. [optional] (default: 'digitalocean') The DNS Service you use
#
# Available DNS Service Providers:
#   - Digital Ocean
#
#-----------------------------------------------------------------------

domain_check_domain_exists()
{
    local LOCAL_DOMAIN LOCAL_DNS_PROVIDER
    
    LOCAL_DOMAIN=${1:-$DOMAIN}
    LOCAL_DNS_PROVIDER=${2:-"digitalocean"}

    [[ $LOCAL_DOMAIN == "" || $LOCAL_DOMAIN == null ]] && echoerror "You must inform the domain name to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if domain '"$LOCAL_DOMAIN"' exists"

    if [[ $LOCAL_DNS_PROVIDER == "digitalocean" ]]; then
        # Digital Ocean ready
        # @todo Add support for CloudFlare and AWS
        RESPONSE="$(curl -X GET -H "Authorization: Bearer $API_KEY" -H "Content-Type: application/json" \
            "https://api.digitalocean.com/v2/domains/$LOCAL_DOMAIN" | jq 'select(.domain != null) | .domain.name')"
    else
        echoerror "The service provider '$LOCAL_DNS_PROVIDER' is not supported by this function [${FUNCNAME[0]}]"
    fi

    [[ "$DEBUG" == true ]] && echo "RESPONSE: "${RESPONSE:-Not found!}

    if [[ ! -z "${RESPONSE}" ]]; then
        DOMAIN_EXIST=true
        return 0
    else
        DOMAIN_EXIST=false
        # @todo improvemnt
        # If domain doesn´t exist create it if error on create then show message
        #MESSAGE="This domain $DOMAIN does not exist in your account."
        #return 1
        return 0
    fi
}
