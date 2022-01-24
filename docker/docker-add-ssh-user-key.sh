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
# 1. Add user's pub key to authorized_keys in a container
#
# You must/might inform the parameters below:
# 1. Container name
# 2. Key string
# 3. [optional] (default: )
#
#-----------------------------------------------------------------------

docker_add_ssh_key_to_main_user()
{
    local LOCAL_CONTAINER LOCAL_SSH_KEY

    LOCAL_CONTAINER="${1:-null}"
    LOCAL_SSH_KEY="${2:-null}"

    [[ $LOCAL_SSH_KEY == "" || $LOCAL_SSH_KEY == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Adding key to container '$LOCAL_CONTAINER'"

    docker exec -it $LOCAL_CONTAINER bash -c "cd && mkdir -p .ssh"
    docker exec -it $LOCAL_CONTAINER bash -c "cd && chmod 600 .ssh"
    docker exec -it $LOCAL_CONTAINER bash -c "cd && echo ${LOCAL_SSH_KEY} >> .ssh/authorized_keys"
    docker exec -it $LOCAL_CONTAINER bash -c "cd && chmod 600 .ssh/authorized_keys"

    return 0
}

