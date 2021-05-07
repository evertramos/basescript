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
# 1. Call other functions in the environment passing parameter through 
# 
# You must/might inform the parameters below:
# 1. Function name
# 2. [optional] (default: null) you can pass up to 4 parameters ]
#
#-----------------------------------------------------------------------

run_function()
{
    local LOCAL_LOG_ACTION

    LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}

    [[ $1 == "" ]] && echoerror "You must inform an argument to the function '${FUNCNAME[0]}', \nplease check the docs."

    [[ "$LOCAL_LOG_ACTION" == true ]] && log "Function $@"

    # Check $SILENT mode
    if [[ "$SILENT" == true ]]; then
        if [[ ! -z $5 ]]; then
            $1 "$2" "$3" "$4" "$5"
        elif [[ ! -z $4 ]]; then
            $1 "$2" "$3" "$4"
        elif [[ ! -z $3 ]]; then
            $1 "$2" "$3"
        elif [[ ! -z $2 ]]; then
            $1 "$2"
        else
            $1
        fi
    else
        echo "${yellow}[start]---------------------------------------------------------------${reset}"

        # Call the specified function
        if [[ -n "$(type -t "$1")" ]] && [[ "$(type -t "$1")" = function ]]; then
            echo "${cyan}Function: \"${1}\"${reset}"
            if [[ ! -z $5 ]]; then
                $1 "$2" "$3" "$4" "$5"
            elif [[ ! -z $4 ]]; then
                $1 "$2" "$3" "$4"
            elif [[ ! -z $3 ]]; then
                $1 "$2" "$3"
            elif [[ ! -z $2 ]]; then
                $1 "$2"
            else
                $1
            fi
        else
            [[ "$LOCAL_LOG_ACTION" == true ]] && log "$@ [ERROR] (Function $1 not found)"
            echo "${red}----------------------------------------------------------------------${reset}"
            echo "${red}|${reset}"
            echo "${red}| [ERROR] Function \"$1\" not found!${reset}"
            echo "${red}|${reset}"
            echo "${red}----------------------------------------------------------------------${reset}"
            echo "${yellow}[ended with ${red}[ERROR]${yellow}]--------------------------------------------------${reset}"
            exit 1
        fi

        # Show result from the function execution
        if [[ $? -ne 0 ]]; then
            [[ "$LOCAL_LOG_ACTION" == true ]] && log "$@ [ERROR]"
            echo "${red}----------------------------------------------------------------------${reset}"
            echo "${red}|${reset}"
            echo "${red}| Ups! Something went wrong...${reset}"
            echo "${red}|${reset}"
            printf "${red}| ${MESSAGE//\\n/\\n|}${reset}"
            echo
            echo "${red}|${reset}"
            echo "${red}----------------------------------------------------------------------${reset}"
            echo "${yellow}[ended with ${red}ERROR${yellow}/WARNING ($?)-----------------------------------------${reset}"
            exit 1
        else
            [[ "$LOCAL_LOG_ACTION" == true ]] && log "$@ [SUCCESS]"
            echo "${green}>>> Success!${reset}"
        fi

        echo "${yellow}[end]-----------------------------------------------------------------${reset}"
        echo
    fi
}
