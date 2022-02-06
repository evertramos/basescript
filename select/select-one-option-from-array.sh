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
# 1. Show options to the user and return one option form the informed array
#
# You must/might inform the parameters below:
# 1. Options which should be shown to the user (array)
# 2. [optional] (default: 'Select one of the options below:') You may
# inform the sentence you want to show to the user
# 3. [optional] (default: 20) Limit options to not break the screen
#
#-----------------------------------------------------------------------

# ----------------------------------------------------------------------
# We have implemented this default value for limiting the quantity of
# options once the screen in a terminal may be limited to a few lines
# if you want to increase you must inform the new limit as variable
# ----------------------------------------------------------------------

select_one_option_from_array()
{
    local LOCAL_OPTIONS LOCAL_LIMIT LOCAL_MESSAGE

    LOCAL_OPTIONS=(${1})
    LOCAL_MESSAGE=${2:-"Select one of the options below:"}
    LOCAL_LIMIT=${3:-20}

    [[ $LOCAL_OPTIONS == "" ]] && echoerror "You must inform the options to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Selecting one option - [function: ${FUNCNAME[0]}]"

    if [[ ${#LOCAL_OPTIONS[@]} -eq 0 ]]; then
        echoerror "There are no options available for selection"
        ERROR_EMPTY_ARRAY_SELECT_ONE_OPTION=true
        return 0
    fi

    if [[ ${#LOCAL_OPTIONS[@]} -gt $LOCAL_LIMIT ]]; then
        echoerror "The number of option is greater than '$LOCAL_LIMIT'" false
        ERROR_LIMIT_SELECT_ONE_OPTION=true
        return 0
    fi

    echo "${blue}-----------------------------------------------------${reset}"
    echo 
    echo "${blue}$LOCAL_MESSAGE"
    echo 

    # Call external function to select option
    select_option "${LOCAL_OPTIONS[@]}"
    SELECT_ONE_OPTION_INDEX=$?
    SELECT_ONE_OPTION_NAME=${LOCAL_OPTIONS[$SELECT_ONE_OPTION_INDEX]}
    echo "${blue}You have selected the option: $SELECT_ONE_OPTION_NAME"
    echo 
    echo "${blue}-----------------------------------------------------${reset}"
}
