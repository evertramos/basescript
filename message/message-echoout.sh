#-----------------------------------------------------------------------
#
# Basescript funtions
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
# Be carefull when editing this file, it is part of a bigger scripts!
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

# Script to show output messages
echoerr() 
{
  local LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-true}

  # Check $SILENT mode
  if [[ "$SILENT" == true ]]; then
    echo $1
  else
    echo "${red}>>> ------------------------------------------------------------------${reset}"
    echo "${red}>>>${reset}"
    echo "${red}>>>[ERROR] $1${reset}" 1>&2; 
#    echo "${red}>>>[ERROR] $@${reset}" 1>&2; 
    echo "${red}>>>${reset}"
    echo "${red}>>> ------------------------------------------------------------------${reset}"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Echo attention
echowarning() 
{
  local LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  # Check $SILENT mode
  if [[ "$SILENT" != true ]]; then
    echo "${yellow}>>> ------------------------------------------------------------------${reset}"
    echo "${yellow}>>>${reset}"
    echo "${yellow}>>>[WARNING] $1${reset}" 1>&2; 
#    echo "${yellow}>>>[WARNING] $@${reset}" 1>&2; 
    echo "${yellow}>>>${reset}"
    echo "${yellow}>>> ------------------------------------------------------------------${reset}"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Echo success
echosuccess() 
{
  local LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  # Check $SILENT mode
  if [[ "$SILENT" != true ]]; then
    echo "${green}>>> ------------------------------------------------------------------${reset}"
    echo "${green}>>>${reset}"
    echo "${green}>>>[SUCCESS] $1${reset}" 1>&2; 
#    echo "${green}>>>[SUCCESS] $@${reset}" 1>&2; 
    echo "${green}>>>${reset}"
    echo "${green}>>> ------------------------------------------------------------------${reset}"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Echo regular line
echoline() 
{
  local LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  # Check $SILENT mode
  if [[ "$SILENT" != true ]]; then
    echo ">>> ------------------------------------------------------------------"
    echo ">>> $1" 1>&2; 
    echo ">>> ------------------------------------------------------------------"
    echo 
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

