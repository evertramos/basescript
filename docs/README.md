# Documentation

The list below is in alphabetical order.

# Requirements

We choose to use some packages which is mostly common in many linux distros, 
sorry if we choose something you would rather not to use or do not have in your distro.
Please consider update the function to embrace you and the community.

- sudo
- dkpg
- apt-install (roadmap to check ditro and use *yum*)

## Usability

@todo

## Functions

- [Documentation](#documentation)
  - [Usability](#usability)
  - [Functions](#functions)
    - [function 1](#function-1)
    - [function 2](#function-2)

--------------------------------

### function 1

### function 2



## System functions

### Check if package is installed

name: *system_check_package_installed*

requirement(s): *dpkg*, [*apt-install*, *sudo*] 

This function has one main objective to check if the informed package is already installed in the system. 
It has an extra option to install the missing package. 
In order to install, the user must have *sudo* configured, *apt-install* installed and *dpkg* package manager.

The install uses the option as below:

```bash
$ apt-get install -y --no-install-recommends $PACKAGE_NAME
```

> If you use other package manager besides *apt-get* you might install manually the required packages once the defatult
> option in this function is to skip the installation process, so you can still use this function in other scripts.
