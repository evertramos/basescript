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
# 1. List (return) tags for the specified image name from docker hub
#
# You must/might inform the parameters below:
# 1. Image name
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

dockerhub_list_tags()
{
    local LOCAL_IMAGE
     
    LOCAL_IMAGE=${1:-null}

    [[ $LOCAL_IMAGE == "" || $LOCAL_IMAGE == null ]] && echoerr "You must inform at least the image name to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Listing tags from docker hub for image '$LOCAL_IMAGE'"

    # This command will filter the number versions and limited to one dot (.)
    DOCKERHUB_LIST_TAGS=($(wget -q https://registry.hub.docker.com/v1/repositories/$LOCAL_IMAGE/tags -O - | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' | grep '^[0-9]' | grep -v '-' | grep -v '\.[0-9]\.'))
}
