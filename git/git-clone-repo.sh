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
# 1. Clone a git repo
#
# You must/might inform the parameters below:
# 1. git repo
# 2. destination path (fullpath)
# 3. [optional] (default: master) branch/tag name
# 4. [optional] (default: null) destination folder if y
# 5. [optional] (default: false) clone full repo with all branches
#
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# This function were designed for automation process on docker services
# having the default option '--depth 1' when cloning a git repository
# set 'true' in the argument above to clone all branches instead
#-----------------------------------------------------------------------

git_clone_repo()
{
    local LOCAL_GIT_REPO LOCAL_FULL_PATH LOCAL_REPO_BRANCH LOCAL_GIT_FOLDER_NAME LOCAL_FULL_REPO
     
    LOCAL_GIT_REPO=${1:-null}
    LOCAL_FULL_PATH=${2:-null}
    LOCAL_REPO_BRANCH=${3:-"master"}
    LOCAL_GIT_FOLDER_NAME=${4}
    LOCAL_FULL_REPO=${5:-false}
 
    [[ $LOCAL_FULL_PATH == "" || $LOCAL_FULL_PATH == null ]] && echoerror "You must inform the 'git repo' and the 'local path' \n to the function: '${FUNCNAME[0]}'"
 
    # Prepare the FULL_PATH with LOCAL_GIT_FOLDER_NAME
    [[ $LOCAL_GIT_FOLDER_NAME != "" ]] && LOCAL_FULL_PATH=${LOCAL_FULL_PATH%/}"/"$LOCAL_GIT_FOLDER_NAME

    [[ "$DEBUG" == true ]] && echo "[git_clone_repo] Testing if repo '$LOCAL_GIT_REPO' on branch '$LOCAL_REPO_BRANCH' is accesible."
    LOCAL_GIT_REPO_ONLINE=$(git ls-remote --exit-code --quiet ${LOCAL_GIT_REPO} --tags ${LOCAL_REPO_BRANCH})
    LOCAL_GIT_REPO_ONLINE=$?
    if [[ $LOCAL_GIT_REPO_ONLINE != 0 ]]; then
        RESPONSE_GIT_CLONE_REPO="Git repo $LOCAL_GIT_REPO with tag ${LOCAL_REPO_BRANCH} is not reachable."
        return 0
    fi

    [[ "$DEBUG" == true ]] && echo "[git_clone_repo] Creating folder '$LOCAL_FULL_PATH'."
    mkdir -p $LOCAL_FULL_PATH > /dev/null 2>&1
    [[ ! -d "$LOCAL_FULL_PATH" ]] && sudo mkdir -p $LOCAL_FULL_PATH > /dev/null 2>&1
    [[ ! -d "$LOCAL_FULL_PATH" ]] && RESPONSE_GIT_CLONE_REPO="Error creating folder '$LOCAL_FULL_PATH'" && return 0

    [[ "$DEBUG" == true ]] && echo "[git_clone_repo] Cloning repo '$LOCAL_GIT_REPO' branch '$LOCAL_REPO_BRANCH' to '$LOCAL_FULL_PATH'."
    if [[ "$LOCAL_FULL_REPO" == true ]]; then
        git clone --branch $LOCAL_REPO_BRANCH $LOCAL_GIT_REPO $LOCAL_FULL_PATH > /dev/null 2>&1
    else
        git clone --depth 1 --branch $LOCAL_REPO_BRANCH $LOCAL_GIT_REPO $LOCAL_FULL_PATH > /dev/null 2>&1
    fi
    if [[ ! -f "${LOCAL_FULL_PATH%/}/.env" ]]; then
      if [[ "$LOCAL_FULL_REPO" == true ]]; then
          sudo git clone --branch $LOCAL_REPO_BRANCH $LOCAL_GIT_REPO $LOCAL_FULL_PATH > /dev/null 2>&1
      else
          sudo git clone --depth 1 --branch $LOCAL_REPO_BRANCH $LOCAL_GIT_REPO $LOCAL_FULL_PATH > /dev/null 2>&1
      fi
    fi

    return 0
}
