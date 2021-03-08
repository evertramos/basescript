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
# 1. Try to get the external IPv4 address of the server
#
# You must/might inform the parameters below:
# 1. n/a
# 2. [optional] (default: ) n/a
#
#-----------------------------------------------------------------------

ip_get_external_ipv4()
{
    IP_EXTERNAL_IPV4=$(ip addr show $(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}' | head -n 1) | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
}
