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
# 1. Delete the domain DNS
#
# You must/might inform the parameters below:
# 1. Domain name(s) (domain.com) - You can inform an array of domains
# 2. [optional] (default: false) Delete even it the domain is running
# in the server proxy
# 3. [optional] (default: 'digitalocean') The DNS Service you use
#
# Available DNS Service Providers:
#   - Digital Ocean
#
#-----------------------------------------------------------------------

domain_delete_domain_dns()
{
    local LOCAL_DOMAINS LOCAL_DELETE_IF_RUNNING LOCAL_DNS_PROVIDER
    
    LOCAL_DOMAINS=($(echo ${1} | tr "," "\n") )
    LOCAL_DELETE_IF_RUNNING=${2:-false}
    LOCAL_DNS_PROVIDER=${3:-"digitalocean"}

    [[ $LOCAL_DOMAINS == "" ]] && echoerror "You need to inform a argunment for the function '${FUNCNAME[0]}'"
    [[ $API_KEY == "" ]] && echoerror "You need an API KEY to use this function ('${FUNCNAME[0]}')"

    for i in ${!LOCAL_DOMAINS[@]}; do
        [[ "$SILENT" != true ]] && echowarning "Deleting dns for url '${LOCAL_DOMAINS[i]}'"

        LOCAL_DOMAIN=${LOCAL_DOMAINS[i]%/}

        if [[ "$LOCAL_DELETE_IF_RUNNING" != true ]]; then
            run_function proxy_check_url_active $LOCAL_DOMAIN
            
            if [[ "$DOMAIN_ACTIVE_IN_PROXY" == true ]]; then
                echoerror "The domain '$LOCAL_DOMAIN' is active in the proxy. Domain not deleted from the DNS."
                return 0
            fi
        fi
    
        [[ "$DEBUG" == true ]] && echowarning "Deleting the DNS record for "$LOCAL_DOMAIN

        if [[ $LOCAL_DNS_PROVIDER == "digitalocean" ]]; then
            # Digital Ocean ready
            # @todo Add support for CloudFlare and AWS
            curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer $API_KEY" \
                "https://api.digitalocean.com/v2/domains/"$LOCAL_DOMAIN

            RESPONSE="$(curl -X GET -H "Authorization: Bearer $API_KEY" -H "Content-Type: application/json" \
                "https://api.digitalocean.com/v2/domains/$LOCAL_DOMAIN" | jq 'select(.domain != null) | .domain.name')"
        else
            echoerror "The service provider '$LOCAL_DNS_PROVIDER' is not supported by this function [${FUNCNAME[0]}]"
        fi

        [[ "$DEBUG" == true ]] && echosuccess "RESPONSE: "$RESPONSE
    done

    if [[ -z "${RESPONSE}" ]]; then
        return 0
    else
        MESSAGE="Error on delete the dns record for $LOCAL_DOMAINS"
        return 1
    fi
}
