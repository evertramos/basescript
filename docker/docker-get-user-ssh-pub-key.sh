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
# 1. Get the user's ssh pub key
#
# You must/might inform the parameters below:
# 1. Container name where user has the key
# 2. Username that public key should be returned
# 3. [optional] The pub key file name (default: id_rsa.pub)
# 4. [optional] The users' home folder (default: /home )
#
#-----------------------------------------------------------------------

docker_get_user_ssh_pub_key()
{
    local LOCAL_CONTAINER LOCAL_USER_NAME LOCAL_KEY_FILE LOCAL_HOME_FOLDER LOCAL_FILE_EXIST_RESULT
    
    LOCAL_CONTAINER=${1:-null}
    LOCAL_USER_NAME=${2:-null}
    LOCAL_KEY_FILE=${3:-id_rsa.pub}
    LOCAL_HOME_FOLDER=${4:-"/home"}

    [[ $LOCAL_USER_NAME == "" || $LOCAL_USER_NAME == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Getting '$LOCAL_USER_NAME' pub key from '$LOCAL_CONTAINER'"

    LOCAL_FILE_EXIST_RESULT=$(docker exec -it $LOCAL_CONTAINER test -f ${LOCAL_HOME_FOLDER%/}/$LOCAL_USER_NAME/.ssh/$LOCAL_KEY_FILE && echo "ok")

    [[ "$LOCAL_FILE_EXIST_RESULT" == "" ]] && echoerror "Error getting the user's pub key (user: $LOCAL_USER_NAME). Please check if your ssh container is running (container: $LOCAL_CONTAINER)."

    DOCKER_USER_SSH_PUB_KEY=$(docker exec -it $LOCAL_CONTAINER cat ${LOCAL_HOME_FOLDER%/}/$LOCAL_USER_NAME/.ssh/$LOCAL_KEY_FILE || 0)

    [[ "$DEBUG" == true ]] && echo "This is key: '$DOCKER_USER_SSH_PUB_KEY'"

    return 0
}

