## Log system

This function will log the basescript activities as you set the _'log'_ function over your scripts.

### Usage

We normally use right after souricing _bootstrap.sh_ file the following lines:

```bash
log "Start execution"
log "'$*'"
```

> This way you will identify the initial part of your script execution and all arguments passed into your script 

### Log variables 

You may set specific values to the environment variables listed below, in order to customize this function as needed:

```bash
BASESCRIPT_LOG_ALL_ACTIONS="true"
BASESCRIPT_LOG_BASE_PATH="/var/log"
BASESCRIPT_LOG_FILE_NAME="basescript.log"
BASESCRIPT_LOG_TIMESTAMP_FLAG="+%Y-%m-%d %H:%M:%S"
```
