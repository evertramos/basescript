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
# 1. Confirm user's action
#
# You must/might inform the parameters below:
# 1. [optional] (default: Are you sure you want to continue?)
# Sentence to show the user to confirm its action.
# 2. [optional] (default: true) Stop and exit (kill) the script on
# users' replying 'no' to do not continue
# 3. [optional] (default: false) Invert the default option from
# 'yes' to 'no'
#
#-----------------------------------------------------------------------

confirm_user_action()
{
    local LOCAL_USER_RESPONSE LOCAL_USER_QUESTION LOCAL_KILL_SCRIPT LOCAL_INVERT_DEFAULT
    
    LOCAL_USER_QUESTION="${1:-Are you sure you want to continue?}"
    LOCAL_KILL_SCRIPT=${2:-true}
    LOCAL_INVERT_DEFAULT=${3:-false}
    
    [[ "$DEBUG" == true ]] && echo "Confirm user's action."

    # The default question is to set "No" 
    if [[ "$LOCAL_INVERT_DEFAULT" == true ]]; then
        LOCAL_USER_QUESTION="$LOCAL_USER_QUESTION \n(default: YES) [Y/n]"
    else
        LOCAL_USER_QUESTION="$LOCAL_USER_QUESTION \n(default: NO) [y/N]"
    fi

    printf "${purple} $question question ${reset}${cyan}${LOCAL_USER_QUESTION//\\n/\\n   }" 1>&2;
    read -r LOCAL_USER_RESPONSE
    echo ${reset}

    # The default question is to return "No" 
    if [[ "$LOCAL_INVERT_DEFAULT" == true ]]; then
        case "$LOCAL_USER_RESPONSE" in
            [nN][oO]|[nN]) 
                USER_ACTION_RESPONSE=false
                ;;
            *)
                USER_ACTION_RESPONSE=true
                ;;
        esac
    else
        case "$LOCAL_USER_RESPONSE" in
            [yY][eE][sS]|[yY]) 
                USER_ACTION_RESPONSE=true
                ;;
            *)
                USER_ACTION_RESPONSE=false
                ;;
        esac
    fi

    [[ "$USER_ACTION_RESPONSE" != true ]] && [[ "$LOCAL_KILL_SCRIPT" == true ]] && echoerror "You have canceled your action. No changes were made."

    return 0
}
