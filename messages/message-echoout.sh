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
echoerror()
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-true}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[ERROR MESSAGE] '$*'"

  # Check $SILENT mode
  if [[ "$SILENT" == true ]]; then
    echo $1
  else
    printf " ${red}${error} ERROR${reset}${yellow}   ${1//\\n/\\n   }${reset}\n" 1>&2;
  fi

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Warning message
echowarning() 
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[WARGNING MESSAGE] '$*'"

  # Check $SILENT mode
  [[ "$SILENT" != true ]] && printf " ${yellow}${warn} WARNING${reset}${yellow} ${1//\\n/\\n   }${reset}\n" 1>&2;

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Info message
echoinfo()
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[INFO MESSAGE] '$*'"

  # Check $SILENT mode
  [[ "$SILENT" != true ]] && printf " ${cyan}${warn} INFO${reset}${cyan} ${1//\\n/\\n   }${reset}\n" 1>&2;

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Success message
echosuccess() 
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[SUCCESS MESSAGE] '$*'"

  # Check $SILENT mode
  [[ "$SILENT" != true ]] && printf " ${green}${check} success${reset}${cyan} ${1//\\n/\\n   }${reset}\n" 1>&2;

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}

# Regular line message
echoline() 
{
  local LOCAL_LOG_ACTION LOCAL_STOP_EXECUTION_ON_ERROR

  LOCAL_LOG_ACTION=${BASESCRIPT_LOG_ALL_ACTIONS:-true}
  LOCAL_STOP_EXECUTION_ON_ERROR=${2:-false}

  [[ "$LOCAL_LOG_ACTION" == true ]] && log "[MESSAGE] '$*'"

  # Check $SILENT mode
  [[ "$SILENT" != true ]] && printf " ${1//\\n/\\n   }\n" 1>&2;

  [[ "$LOCAL_STOP_EXECUTION_ON_ERROR" == true ]] && exit 1
}
