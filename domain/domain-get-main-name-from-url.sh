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
# 1. Extract the main domain name from an URL (ex. go.futher.maindomainname.com.es
# will return 'maindomainname'
#
# You must/might inform the parameters below:
# 1. URL which should return the main domain name
# 2. [optional] (default: false) Return the top-level domains
#
#-----------------------------------------------------------------------

domain_get_main_name_from_url()
{
    local LOCAL_URL LOCAL_RETURN_TOP_LEVEL_DOMAIN

    LOCAL_URL="${1:-null}"
    LOCAL_RETURN_TOP_LEVEL_DOMAIN="${2:-false}"

    [[ $LOCAL_URL == "" || $LOCAL_URL == null ]] && echoerror "You must inform an URL to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Getting the main domain name from a URL."

    LOCAL_URL="$(echo $LOCAL_URL | sed -e 's|www.||' -e 's|^[^/]*//||' -e 's|/.*$||')"

    if [[ "$LOCAL_RETURN_TOP_LEVEL_DOMAIN" == true ]]; then
        DOMAIN_MAIN_NAME_FROM_URL="$(echo $LOCAL_URL | awk '{
                                                      gsub( "^.*://", "", $1 ); # remove http:// ftp:// (already done by sed above)
                                                      n = split( $1, a, "." );
                                                      if( length( a[n] ) == 2 )
                                                          printf( "%s.%s.%s\n", a[n-2], a[n-1], a[n] );
                                                      else
                                                          printf( "%s.%s\n",  a[n-1], a[n] );
                                                      }')"
    else
        DOMAIN_MAIN_NAME_FROM_URL="$(echo $LOCAL_URL | awk '{
                                                      gsub( "^.*://", "", $1 ); # remove http:// ftp:// (already done by sed above)
                                                      n = split( $1, a, "." );
                                                      if( length( a[n] ) == 2 )
                                                          printf( "%s\n", a[n-2], a[n-1], a[n] );
                                                      else
                                                          printf( "%s\n",  a[n-1], a[n] );
                                                      }')"
    fi
}
