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
# 1. Check if a package is installed and install it if it is not
#
# You must/might inform the parameters below:
# 1. Package name
# 2. [optional] (default: false) Install package
#
#-----------------------------------------------------------------------

system_check_package_installed()
{
    local LOCAL_PACKAGE LOCAL_INSTALL_PACKAGED LOCAL_RESULT
     
    LOCAL_PACKAGE=${1:-null}
    LOCAL_INSTALL_PACKAGED=${2:-false}

    [[ $LOCAL_PACKAGE == "" ]] && echoerror "You must inform the PACKAGE NAME to the function: '${FUNCNAME[0]}'"
 
    [[ "$DEBUG" == true ]] && echo "Checking if package '$LOCAL_PACKAGE' is installed."

    LOCAL_RESULT=$(dpkg -s $LOCAL_PACKAGE >/dev/null 2>&1 || echo 1)

    if [[ "$LOCAL_INSTALL_PACKAGED" == true ]] && [[ $LOCAL_RESULT == 1 ]]; then
        [[ "$DEBUG" == true ]] && echo "Installing package '$LOCAL_PACKAGE'."

        sudo apt-get install -y --no-install-recommends $LOCAL_PACKAGE || echoerror "There were errors when installing package '$LOCAL_PACKAGE'."
        
        LOCAL_RESULT=$(dpkg -s tars >/dev/null 2>&1)
    fi
    
    if [[ $LOCAL_RESULT != '' ]]; then
        PACKAGE_IS_INSTALLED=true 
    else
        PACKAGE_IS_INSTALLED=false
    fi
}

