#!/bin/bash

# Arguments check
if [ $# -ne 2 ]; then
    echo "USAGE: update_galera_config.bash [field] [value]"
    exit;
fi

sed -i "s|$1=.*|$1=\"$2\"|" /etc/haproxy/galera.cnf && echo "> \"$1 $2\" added to /etc/mysql/conf.d/galera.cnf"