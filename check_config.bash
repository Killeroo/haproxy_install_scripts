#!/bin/bash
# checks integrity of config file
# Based off: http://wiki.bash-hackers.org/howto/conffile

# Check config file exists
if [ ! -f $PWD/setup.cnf ]; then
	echo 1
	exit;
fi

# Check key fields arent empty
source $PWD/setup.cnf
if [ -z $ha_policy ]; then
    echo 2 && exit;
elif [ -z $db_address ]; then
    echo 2 && exit;
fi

# config file is good
echo 0;