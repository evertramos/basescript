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
# 1. Remove a user key from a container
#
# You must/might inform the parameters below:
# 1. Container name
# 2. Username
# 3. [optional] (default:)
#
#-----------------------------------------------------------------------

docker_remove_user_ssh_key()
{
    local LOCAL_CONTAINER LOCAL_USER_NAME LOCAL_SKIP_ON_ERROR

    LOCAL_CONTAINER="${1:-null}"
    LOCAL_USER_NAME="${2:-null}"

    [[ $LOCAL_CONTAINER == "" ]] && echoerror "You must inform a container to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Removing $LOCAL_USER_NAME's key in $LOCAL_CONTAINER"

    if [[ "$SILENT" == true ]]; then
        docker exec -it $LOCAL_CONTAINER bash -c "cd && sed -i '\| $LOCAL_USER_NAME@|d' .ssh/authorized_keys" 2>&1 > /dev/null
    else
        docker exec -it $LOCAL_CONTAINER bash -c "cd && sed -i '\| $LOCAL_USER_NAME@|d' .ssh/authorized_keys"
    fi

    return 0
}
