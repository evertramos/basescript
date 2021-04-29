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
# Be careful when editing this file, it is part of a bigger scripts!
#
# Basescript - https://github.com/evertramos/basescript
#
#-----------------------------------------------------------------------

# ----------------------------------------------------------------------
# This function has one main objective:
# 1. Show output messages
#
# You must inform the parameters below:
# 1. Message that should be outputed
# 2. [optional] Stopping execution on messaging (default: 'depends')
#
# ----------------------------------------------------------------------

# Error message
echoerr()
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-true}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[ERROR MESSAGE] $@"

  # Check $SILENT mode
  if [[ "$SILENT" == true ]]; then
    echo $1
  else
    echo "${red}[ERROR]---------------------------------------------------------------${reset}"
    printf "${red}${1//\\n/\\n}${reset}" 1>&2;
    echo
    echo "${red}----------------------------------------------------------------------${reset}"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Warning message
echowarning() 
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[WARGNING MESSAGE] $@"

  # Check $SILENT mode
  if [[ "$SILENT" != true ]]; then
    echo "${yellow}[WARNING]-------------------------------------------------------------${reset}"
    printf "${yellow}${1//\\n/\\n}${reset}" 1>&2;
    echo
    echo "${yellow}----------------------------------------------------------------------${reset}"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Success message
echosuccess() 
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[SUCCESS MESSAGE] $@"

  # Check $SILENT mode
  if [[ "$SILENT" != true ]]; then
    echo "${green}[SUCCESS]-------------------------------------------------------------${reset}"
    printf "${green}${1//\\n/\\n}${reset}" 1>&2;
    echo
    echo "${green}----------------------------------------------------------------------${reset}"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Regular line message
echoline() 
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[MESSAGE] $@"

  # Check $SILENT mode
  if [[ "$SILENT" != true ]]; then
    echo "----------------------------------------------------------------------"
    printf " ${1//\\n/\\n}" 1>&2;
    echo
    echo "----------------------------------------------------------------------"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}
