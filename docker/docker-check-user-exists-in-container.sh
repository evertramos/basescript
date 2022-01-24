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
# 1. Check if a username already exists in a specific container
#
# You must/might inform the parameters below:
# 1. Container name to check if a user already exists
# 2. Username that should be checked
#
#-----------------------------------------------------------------------

docker_check_user_exists_in_container()
{
    local LOCAL_SSH_CONTAINER LOCAL_USER_NAME LOCAL_RESULT

    LOCAL_SSH_CONTAINER="${1:-null}"
    LOCAL_USER_NAME=${2:-null}

    [[ $LOCAL_USER_NAME == "" || $LOCAL_USER_NAME == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Checking if user '$LOCAL_USER_NAME' exists in '$LOCAL_SSH_CONTAINER'"

    LOCAL_RESULT=$(docker exec -it $LOCAL_SSH_CONTAINER id -u $LOCAL_USER_NAME > /dev/null 2>&1; echo $?)

    # Check results
    if [[ "$LOCAL_RESULT" == 0 ]]; then
        DOCKER_USER_EXISTS_IN_CONTAINER=true
    else
        DOCKER_USER_EXISTS_IN_CONTAINER=false
    fi
}

