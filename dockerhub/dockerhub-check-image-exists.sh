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

    # This command will filter the number versions and limited to one dot (.)
    LOCAL_RESPONSE=$(curl --write-out '%{http_code}' --silent --output /dev/null https://hub.docker.com/v2/namespaces/library/repositories/$LOCAL_IMAGE/tags/$LOCAL_TAG)

    if [[ $LOCAL_RESPONSE == "200" ]]; then
        DOCKERHUB_IMAGE_EXISTS=true
    else
        DOCKERHUB_IMAGE_EXISTS=false
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    FUNCTION_NAME=dockerhub_check_image_exists

    BASESCRIPT_LOG_ALL_ACTIONS=false
    source ./../messages/message-echoout.sh
    source ./../init/color.sh
    source ./../init/symbol.sh
    LOCAL_RESULT=$($FUNCTION_NAME $1 $2 2>&1)

    RETURN_CODE=$?
    if [[ $LOCAL_RESULT == *"ERRO"* ]] || [[ $LOCAL_RESULT == *"erro"* ]] || [[ "$RETURN_CODE" != 0 ]]; then
        printf "${red}$cross Error\n${reset}"
        printf "Function: '$FUNCTION_NAME'\nOutput:\n$LOCAL_RESULT\n"
    else
        printf "${green}$check test passed!\n${reset}"
    fi
fi
