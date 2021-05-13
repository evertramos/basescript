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

    case "$LOCAL_PROXY_SERVICE" in
        "nginx-proxy")
        LOCAL_CHECK_URL_ACTIVE_PROXY=$(cat $PROXY_FOLDER/data/conf.d/default.conf | grep "upstream $LOCAL_URL" | wc -l)
        shift 2
        ;;
        *)
        echoerror "The proxy service '$LOCAL_PROXY_SERVICE' is not supported by this function [${FUNCNAME[0]}]"
        ;;
    esac

    if [[ $LOCAL_CHECK_URL_ACTIVE_PROXY > 0 ]]; then
        DOMAIN_ACTIVE_IN_PROXY=true
    else
        DOMAIN_ACTIVE_IN_PROXY=false
    fi

    return 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    FUNCTION_NAME=proxy_check_url_active

    BASESCRIPT_LOG_ALL_ACTIONS=false
    source ./../messages/message-echoout.sh
    source ./../init/color.sh
    source ./../init/symbol.sh
    LOCAL_RESULT=$($FUNCTION_NAME $1 $2 2>&1)

    RETURN_CODE=$?
    if [[ $LOCAL_RESULT == *"ERRO"* ]] || [[ $LOCAL_RESULT == *"erro"* ]] || [[ "$RETURN_CODE" != 0 ]]; then
        printf "${red}$cross Error\n${reset}"
        printf "Function: '$FUNCTION_NAME'\nOutput:\n$LOCAL_RESULT\n"
    else
        printf "${green}$check test passed!\n${reset}"
    fi
fi

