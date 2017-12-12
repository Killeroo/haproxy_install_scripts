#!/bin/bash

# Interupter check
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@     PLEASE RUN SCRIPT WITH BASH!      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@       PLEASE RUN SCRIPT AS ROOT!      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

echo "-> Starting installation"

# Check config file
config_status=$(bash check_config.bash)
if [ $config_status -eq 1 ]; then
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@          SETUP.CNF NOT FOUND!         @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "Please ensure this file exists @ $PWD"
    echo "then try again."
    exit
elif [ $config_status -eq 2 ]; then
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@          SETUP.CNF IS EMPTY!          @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "Please enter details into $PWD/setup.cnf"
    echo "then try again."
    exit;
fi
echo "-> Config file good"
source $PWD/setup.cnf

echo "-> Installing base packages..."
sudo apt-get update -y
sudo apt-get install -y nano git software-properties-common
echo "-> Installing HAProxy..."
sudo apt-get install -y haproxy
echo "-> Copying config file..."
sudo cp $PWD/haproxy.cfg /etc/haproxy/haproxy.cfg
echo "-> Starting HAProxy..."

echo "-> HAProxy started."
echo "-> Installation Complete."