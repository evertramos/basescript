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
# 1. Select multiple data in a list
#
# You must/might inform the parameters below:
# 1. An array with the list the user may choose from
# 2. [optional] (default: )
#
#-----------------------------------------------------------------------

select_multiple_data()
{
    GLOBAL_MULTIDATA_SELECT_DATA=(${1})

    [[ $GLOBAL_MULTIDATA_SELECT_DATA == ""  || ${#GLOBAL_MULTIDATA_SELECT_DATA[@]} -eq 0 ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Multiselect data for the user."

    # The codes below were adapted from: https://serverfault.com/questions/144939/multi-select-menu-in-bash-script
    prompt="${cyan}Check an option (again to uncheck, ENTER when done): ${reset}"
    while menu_multiselect && read -rp "$prompt" num && [[ "$num" ]]; do
        [[ "$num" != *[![:digit:]]* ]] &&
        (( num > 0 && num <= ${#GLOBAL_MULTIDATA_SELECT_DATA[@]} )) ||
        { msg="${red}Invalid option: $num${reset}"; continue; }
        ((num--)); msg="${yellow}${GLOBAL_MULTIDATA_SELECT_DATA[num]} was ${choices[num]:+un}checked${reset}"
        [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
    done

    printf "${yellow}You have selected:${reset}"; msg="${red} nothing${reset}"
    for i in ${!GLOBAL_MULTIDATA_SELECT_DATA[@]}; do
        if [[ "${choices[i]}" ]]; then
            printf "${green} %s" "${GLOBAL_MULTIDATA_SELECT_DATA[i]}" "${reset}"
             msg=""
            USER_MULTIDATA_SELECTIONS+=("${GLOBAL_MULTIDATA_SELECT_DATA[i]}") 
        fi
    done
    echo "$msg"

    if [[ $USER_MULTIDATA_SELECTIONS == "" ]]; then
        echoerror "You must select at least one option to continue. Please run the script again."
#    else
#        for i in "${USER_MULTIDATA_SELECTIONS[@]}"; do
#            echo "sites selected: $i"
#        done
    fi

    return 0
}

# ----------------------------------------------------------------------------
# The function below was extracted from:
# https://serverfault.com/questions/144939/multi-select-menu-in-bash-script
# ----------------------------------------------------------------------------
menu_multiselect()
{
    echo "${cyan}-----------------------------------------------------${reset}"
    echo 
    echo "${cyan}Avaliable options:${reset}"
    echo 

    for i in ${!GLOBAL_MULTIDATA_SELECT_DATA[@]}; do
        if [[ ${choices[i]} == "+" ]]; then
            printf "${green}%3d%s) %s\n" $((i+1)) "${choices[i]:-}" "${GLOBAL_MULTIDATA_SELECT_DATA[i]}${reset}"
        else
            printf "${cyan}%3d%s) %s\n" $((i+1)) "${choices[i]:-}" "${GLOBAL_MULTIDATA_SELECT_DATA[i]}${reset}"
        fi
    done
    [[ "$msg" ]] && echo "$msg"; :
}

