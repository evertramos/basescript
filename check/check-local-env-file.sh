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
# 1. Check if there is an .env file in the current folder and source it
#
# You must/might inform the parameters below:
# 1. n/a
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

check_local_env_file()
{
    [[ "$DEBUG" == true ]] && echo "Check if local '.env' file is set."

    if [[ -e .env ]]; then
        source .env
    else 
        MESSAGE="'.env' file not found at '$(pwd)/'! \n\n Please check!"
        return 1
    fi
}
