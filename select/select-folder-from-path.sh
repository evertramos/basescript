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
# 1. List folder from a path so user select one option
#
# You must/might inform the parameters below:
# 1. Base path folder to list all sub-folders from
# 2. [optional] (default: 'Select one of the folder below:') You may
# inform the sentence you want to show to the user
# 4. [optional] (default: null) String to filter the listed options
# 3. [optional] (default: 20) Limit options to not break the screen
#
#-----------------------------------------------------------------------

# ----------------------------------------------------------------------
# We have implemented this default value for limiting the quantity of
# options once the screen in a terminal may be limited to a few lines
# if you want to increase you must inform the new limit as variable
# ----------------------------------------------------------------------

select_folder_from_path()
{
    local LOCAL_BASE_FOLDER LOCAL_LIMIT LOCAL_MESSAGE LOCAL_FILTER_STRING LOCAL_OPTIONS

    LOCAL_BASE_FOLDER=${1:-null}
    LOCAL_MESSAGE=${2:-"Select one of the folders below:"}
    LOCAL_FILTER_STRING=${3:-null}
    LOCAL_LIMIT=${4:-20}

    [[ $LOCAL_BASE_FOLDER == "" || $LOCAL_BASE_FOLDER == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echowarning "Selecting a folder from: ${LOCAL_BASE_FOLDER} - [function: ${FUNCNAME[0]}]"

    # Source all folder to an array
    cd $LOCAL_BASE_FOLDER
    if [[ ! $LOCAL_FILTER_STRING == "" && ! $LOCAL_FILTER_STRING == null ]]; then
        LOCAL_OPTIONS=($(ls -d */ | sed 's#/##' | grep $LOCAL_FILTER_STRING))
    else
        LOCAL_OPTIONS=($(ls -d */ | sed 's#/##'))
    fi
    cd - > /dev/null 2>&1

    if [[ ${#LOCAL_OPTIONS[@]} -eq 0 ]]; then
        echoerror "There are no folder in this path: ${LOCAL_BASE_FOLDER}"
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
