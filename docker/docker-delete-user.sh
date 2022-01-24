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
# 1. Delete a user from a container
#
# You must/might inform the parameters below:
# 1. Container name
# 2. Username
# 3. [optional] (default: )
#
#-----------------------------------------------------------------------

docker_delete_user()
{
    local LOCAL_CONTAINER LOCAL_USER_NAME
    
    LOCAL_CONTAINER=${1:-null}
    LOCAL_USER_NAME=${2:-null}

    [[ $LOCAL_USER_NAME == "" || $LOCAL_USER_NAME == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Deleting user '$LOCAL_USER_NAME' from container '$LOCAL_CONTAINER'."

    if [[ "$SILENT" == true ]]; then
        docker exec -it $LOCAL_CONTAINER userdel --remove $LOCAL_USER_NAME 2>&1 > /dev/null
    else
        docker exec -it $LOCAL_CONTAINER userdel --remove $LOCAL_USER_NAME
    fi

    return 0
}

