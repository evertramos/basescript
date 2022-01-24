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
# 1. Add a user with an ssh key in a container
#
# You must/might inform the parameters below:
# 1. Container name
# 2. Username
# 3. Key string
# 4. [optional] (default: )
#
#-----------------------------------------------------------------------

docker_add_user_with_key()
{
    local LOCAL_CONTAINER LOCAL_USER_NAME LOCAL_SSH_KEY LOCAL_KEY_PASSWORD
    
    LOCAL_CONTAINER=${1:-null}
    LOCAL_USER_NAME=${2:-null}
    LOCAL_SSH_KEY="${3:-null}"

    [[ $LOCAL_SSH_KEY == "" || $LOCAL_SSH_KEY == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    run_function common_generate_random_string 30

    LOCAL_KEY_PASSWORD=$RANDOM_STRING

    [[ "$DEBUG" == true ]] && echo "Creating user '$LOCAL_USER_NAME' for container '$LOCAL_CONTAINER'."

    #docker exec -it $LOCAL_CONTAINER adduser -D -h /home/$LOCAL_USER_NAME/ $LOCAL_USER_NAME $LOCAL_USER_NAME
    # We have used this option '-k /home_user' in order to accomplish the config file to use root user to access site's container
    # This option is in the repo https://github.com/evertramos/docker-ssh-bastion
    docker exec -it $LOCAL_CONTAINER adduser -D -h /home/$LOCAL_USER_NAME/ -k /home_user $LOCAL_USER_NAME $LOCAL_USER_NAME

    docker exec -it $LOCAL_CONTAINER usermod --password "$LOCAL_KEY_PASSWORD" $LOCAL_USER_NAME

    docker exec -it $LOCAL_CONTAINER chown $LOCAL_USER_NAME.$LOCAL_USER_NAME -R /home/$LOCAL_USER_NAME

    docker exec -it $LOCAL_CONTAINER su -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa" $LOCAL_USER_NAME

    docker exec -it $LOCAL_CONTAINER su -c "echo $LOCAL_SSH_KEY >> /home/$LOCAL_USER_NAME/.ssh/authorized_keys" $LOCAL_USER_NAME
    
    docker exec -it $LOCAL_CONTAINER chmod 700 /home/$LOCAL_USER_NAME/.ssh
    docker exec -it $LOCAL_CONTAINER chmod 644 /home/$LOCAL_USER_NAME/.ssh/config
    docker exec -it $LOCAL_CONTAINER chmod 600 /home/$LOCAL_USER_NAME/.ssh/authorized_keys
}
