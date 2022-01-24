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
# 1. Comment a line in file
#
# You must/might inform the parameters below:
# 1. Full file path
# 2. String to find the correct line in file
# 3. [optional] (default: '#') comment mark
#
#-----------------------------------------------------------------------

file_comment_line_with_string()
{
    local LOCAL_FULL_FILE_PATH LOCAL_STRING LOCAL_COMMENT_MARK

    LOCAL_FULL_FILE_PATH="${1:-null}"
    LOCAL_STRING="${2:-null}"
    LOCAL_COMMENT_MARK="${3:-#}"
    LOCAL_ALLOW_RUN_WITH_SUDO=${ALLOW_RUN_WITH_SUDO:-true}

    # Check required 
    [[ $LOCAL_FULL_FILE_PATH == "" || $LOCAL_FULL_FILE_PATH == null || $LOCAL_STRING == "" || $LOCAL_STRING == null ]] && \
        echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    # Check if file exists | exit if 4th parameter is set to 'true'
    [[ ! -f $LOCAL_FULL_FILE_PATH ]] && echoerror "We could not find the file '$LOCAL_FULL_FILE_PATH' in your local folder. \nPlease inform the correct location and try again (function: ${FUNCNAME[0]})."

    # Debug message 
    [[ "$DEBUG" == true ]] && echo "Uncommenting '$LOCAL_STRING' in '$LOCAL_FULL_FILE_PATH' removing the '$LOCAL_COMMENT_MARK'."

    # Allows 'sudo' to run this function if destination path it's not owned by the current user
    [[ "$LOCAL_ALLOW_RUN_WITH_SUDO" == true ]] && ! system_check_user_folder_owner ${LOCAL_FULL_FILE_PATH%/*} && LOCAL_RUN_WITH_SUDO=sudo

    $LOCAL_RUN_WITH_SUDO sed -i '/'"$LOCAL_STRING"'/s/^/'"$LOCAL_COMMENT_MARK"'/g' "$LOCAL_FULL_FILE_PATH"
}
