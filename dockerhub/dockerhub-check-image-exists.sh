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
# 1. Check if an image exists in docker hub
#
# You must/might inform the parameters below:
# 1. Image name
# 2. [optional] (default: 'lagest') Tag name/number
#
#-----------------------------------------------------------------------

dockerhub_check_image_exists()
{
    local LOCAL_IMAGE LOCAL_TAG LOCAL_RESPONSE
     
    LOCAL_IMAGE=${1:-null}
    LOCAL_TAG=${2:-"latest"}
 
    [[ $LOCAL_IMAGE == "" || $LOCAL_IMAGE == null ]] && echoerror "You must inform at least the image name to the function: '${FUNCNAME[0]}'"
 
    [[ "$DEBUG" == true ]] && echo "Checking if image '$LOCAL_IMAGE:$LOCAL_TAG' exists in docker hub"

    #TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${UNAME_DOCKERHUB}'", "password": "'${UPASS_DOCKERHUB}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
    # This command will filter the number versions and limited to one dot (.)
    LOCAL_RESPONSE=$(curl --write-out '%{http_code}' --silent --output /dev/null https://hub.docker.com/v2/repositories/$LOCAL_IMAGE/tags/$LOCAL_TAG/)
    
    if [[ $LOCAL_RESPONSE == "200" ]]; then
        DOCKERHUB_IMAGE_EXISTS=true
    else
        DOCKERHUB_IMAGE_EXISTS=false
    fi
}

