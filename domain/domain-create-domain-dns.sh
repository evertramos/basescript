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
# 1. Create a DNS record
#
# You must/might inform the parameters below:
# 1. Domain name
# 2. [optional] (default: 'digitalocean') The DNS Service you use
# 3. [optional] (default: false) Stop script execution on error
#
# Available DNS Service Providers:
#   - Digital Ocean
#
#-----------------------------------------------------------------------

domain_create_domain_dns()
{
    local LOCAL_DOMAIN LOCAL_DNS_PROVIDER LOCAL_ERROR LOCAL_STOP_EXECUTION_ON_ERROR
    
    LOCAL_DOMAIN=${1:-$DOMAIN}
    LOCAL_DNS_PROVIDER=${2:-"digitalocean"}
    LOCAL_STOP_EXECUTION_ON_ERROR=${3:-false}

    [[ "$DEBUG" == true ]] && echo "Creating a DNS record for "$LOCAL_DOMAIN

     if [[ $LOCAL_DNS_PROVIDER == "digitalocean" ]]; then
        # Digital Ocean ready
        # @todo Add support for CloudFlare and AWS
        RESPONSE="$(curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $API_KEY" \
            -d "{\"name\":\"$LOCAL_DOMAIN\", \"ip_address\":\"$IPv4\"}" "https://api.digitalocean.com/v2/domains")"
            #-d "{\"name\":\"$LOCAL_DOMAIN\", \"ip_address\":\"$IPv4\"}" "https://api.digitalocean.com/v2/domains" \
            #| jq 'select(.domain != null) | .domain.name')"
    else
        echoerror "The service provider '$LOCAL_DNS_PROVIDER' is not supported by this function [${FUNCNAME[0]}]"
    fi

    [[ "$DEBUG" == true ]] && echo "RESPONSE: "${RESPONSE:-Error on create domain $LOCAL_DOMAIN!}

    # Check if there were an error on creating the domain
    LOCAL_ERROR=$(echo $RESPONSE | grep "unprocessable_entity")
    if [[ $LOCAL_ERROR != "" ]]; then
        [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && echoerror "Error on running '${FUNCNAME[0]}' with output '$RESPONSE'"
        domain_create_domain_dns_ERROR=true
    else
        domain_create_domain_dns_ERROR=false
    fi
}
