#!/bin/bash
# Adds a node address to the HAProxy config

# Check for 2 arguments (1 optional)
# Arguments check
if [ $# -lt 2 ]; then
    echo "USAGE: add_node.bash [address] [node number] [weight (OPTIONAL)]"
    exit;
fi

if [ -z "$3" ]; then
    $weight=1
else
    $weight=$3
fi

echo "     server node$2 $1:3306 check weight $3" >> /etc/haproxy/haproxy.cfg && "> Node$2 $1 (with weight $3) added to /etc/haproxy/haproxy.cfg"