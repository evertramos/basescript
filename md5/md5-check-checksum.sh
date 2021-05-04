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
# 1. Verify the checksum of a file
#
# You must/might inform the parameters below:
# 1. Path (only) for the file to compare the checksum
# 2. File name which should have the checksum verified
# 3. Checksum string to compare
#
#-----------------------------------------------------------------------

md5_check_checksum()
{
    local LOCAL_FILE_PATH LOCAL_FILE_NAME LOCAL_CHECKSUM_STRING LOCAL_RESULT
    
    LOCAL_FILE_PATH=${1:-null}
    LOCAL_FILE_NAME=${2:-null}
    LOCAL_CHECKSUM_STRING=${3:-null}

    [[ $LOCAL_FILE_PATH == "" || $LOCAL_FILE_PATH == null || \
        LOCAL_FILE_NAME == "" || $LOCAL_FILE_NAME == null || \
        $LOCAL_CHECKSUM_STRING == "" || $LOCAL_CHECKSUM_STRING == null ]] && \
        echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "Verifying checksum for '$LOCAL_FILE_PATH/$LOCAL_FILE_NAME' > [$LOCAL_CHECKSUM_STRING]."

    cd $LOCAL_FILE_PATH
    LOCAL_RESULT=$(echo "$LOCAL_CHECKSUM_STRING  $LOCAL_FILE_NAME" | md5sum --quiet -c -)
    cd - > /dev/null 2>&1

    # Check results
    if [[ "$LOCAL_RESULT" == "" ]]; then
        MD5_CHECKSUM=true
    else 
        MD5_CHECKSUM=false
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    md5_check_checksum $1 $2 $3
    echo $MD5_CHECKSUM
fi
