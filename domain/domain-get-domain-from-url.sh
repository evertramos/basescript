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
# 1. Extract the domain name from an URL
#
# You must/might inform the parameters below:
# 1. URL which should return the domain name
# 2. [optional] (default: true) Remove 'www' from the URL
#
#-----------------------------------------------------------------------

domain_get_domain_from_url()
{
    local LOCAL_URL LOCAL_REMOVE_WWW_FROM_URL

    LOCAL_URL="${1:-null}"
    LOCAL_REMOVE_WWW_FROM_URL="${2:-true}"

    [[ $LOCAL_URL == "" || $LOCAL_URL == null ]] && echoerror "You must inform an URL to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Getting the domain name from a URL."

    if [[ "$LOCAL_URL" != '' ]]; then
        if [[ "$LOCAL_REMOVE_WWW_FROM_URL" == true ]]; then
            DOMAIN_URL_RESPONSE="$(echo $LOCAL_URL | sed -e 's|www.||' -e 's|^[^/]*//||' -e 's|/.*$||')"
        else
            DOMAIN_URL_RESPONSE="$(echo $LOCAL_URL | sed -e 's|^[^/]*//||' -e 's|/.*$||')"
        fi
    else
       [[ "$SILENT" != true ]] && echoerror "You must inform the URL in order the extract the domain name."
    fi
}
