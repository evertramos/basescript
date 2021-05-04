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
# 1. Create a domain in your DNS service if it does not exist
#
# You must/might inform the parameters below:
# 1. Domain name (domain.com)
# 2. [optional] (default: false) Stop script execution if the required
# domain is already active in the proxy
# 3. [optional] (default: 'digitalocean') The DNS Service you use
# 4. [optional] (default: 'nginx-proxy') The proxy option you are
# running in the server
#
# Available DNS Service Providers:
#   - Digital Ocean
#
#-----------------------------------------------------------------------

domain_create_domain_if_not_exist()
{
    local LOCAL_DOMAIN LOCAL_STOP_EXECUTION_IF_RUNNING LOCAL_DNS_PROVIDER LOCAL_PROXY_SERVICE

    LOCAL_DOMAIN=${1}
    LOCAL_STOP_EXECUTION_IF_RUNNING=${2:-false}
    LOCAL_DNS_PROVIDER=${3:-"digitalocean"}
    LOCAL_PROXY_SERVICE=${4:-"nginx-proxy"}

    [[ $LOCAL_DOMAIN == "" || $LOCAL_DOMAIN == null ]] && echoerror "You must inform a Domain name to the function '${FUNCNAME[0]}'"
    [[ $API_KEY == "" ]] && echoerror "You need an API KEY to use the function ('${FUNCNAME[0]}')"

    [[ "$DEBUG" == true ]] && echowarning "Creating the domain '$LOCAL_DOMAIN' if it does not exist in the DNS records"

    # Check if url exist
    run_function domain_check_domain_exists $LOCAL_DOMAIN $LOCAL_DNS_PROVIDER

    # If url does not exists create subdomain
    if [[ "$DOMAIN_EXIST" == false ]]; then
        run_function domain_create_domain_dns $LOCAL_DOMAIN $LOCAL_DNS_PROVIDER

        # Verify if there were an error on creating the new domain
        if [[ "$domain_create_domain_dns_ERROR" == true ]]; then
            echoerror "Error on creating the domain '$LOCAL_DOMAIN' - response '$RESPONSE'" false
        fi

        # Check AGAIN if url exist
        run_function domain_check_domain_exists $LOCAL_DOMAIN $LOCAL_DNS_PROVIDER

        # If url does not exists create subdomain
        if [[ "$DOMAIN_EXIST" == false ]]; then
            echoerror "It seems there is an error related to the domain '$LOCAL_DOMAIN' - response '$RESPONSE'" false
        fi

        DOMAIN_CREATED=true
    fi

    # Check if domain is active in the proxy
    run_function proxy_check_url_active $LOCAL_DOMAIN $LOCAL_PROXY_SERVICE

    if [[ "$DOMAIN_ACTIVE_IN_PROXY" == true ]]; then
        DOMAIN_ALREADY_ACTIVE_IN_PROXY=true
        [[ "$LOCAL_STOP_EXECUTION_IF_RUNNING" == true ]] && echoerror "The domain '$LOCAL_DOMAIN' is active in the proxy."
    else
        DOMAIN_ALREADY_ACTIVE_IN_PROXY=false
    fi
    
    return 0
}
