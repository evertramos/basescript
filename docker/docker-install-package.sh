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
# 1. Install a package inside a container
#
# You must/might inform the parameters below:
# 1. Container where the package should be installed
# 2. The package name which should be installed
#
#-----------------------------------------------------------------------

docker_install_package_with_apt()
{
    local LOCAL_CONTAINER LOCAL_PACKAGE_NAME LOCAL_RESULT

    LOCAL_CONTAINER="${1:-null}"
    LOCAL_PACKAGE_NAME="${2:-null}"

    [[ $LOCAL_PACKAGE_NAME == "" || $LOCAL_PACKAGE_NAME == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Installing package '$LOCAL_PACKAGE_NAME' in container '$LOCAL_CONTAINER'"
    docker exec -it $LOCAL_CONTAINER apt update
    docker exec -it $LOCAL_CONTAINER apt install -y --no-install-recommends "$LOCAL_PACKAGE_NAME"

    [[ "$DEBUG" == true ]] && echo "Clean up apt"
    docker exec -it $LOCAL_CONTAINER rm -rf /var/lib/apt/lists/*
    docker exec -it $LOCAL_CONTAINER apt clean

    return 0
}

