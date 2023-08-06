#!/bin/bash

# Path to your hosts file
hostsFile="/etc/hosts"

# Default IP address for host
ip="127.0.0.1"


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi


yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

add() {
    if [ -n "$(grep -P "[[:space:]]$1" /etc/hosts)" ]; then
        yell "$1, already exists: $(grep $1 $hostsFile)\n";
    else
        echo "Adding $1 to $hostsFile...";
        try printf "%s\t%s\n" "$ip" "$1" | sudo tee -a "$hostsFile" > /dev/null;

        if [ -n "$(grep $1 /etc/hosts)" ]; then
            echo "$1 was added succesfully:";
            echo "$(grep $1 /etc/hosts)";
        else
            die "Failed to add $hostname";
        fi
    fi
}


add "dev.phpmyadmin.com"
add "dev.adminer.local"
add "dev.admin.tickets.com"
add "dev.tickets-api.com"
add "tickets-api.local"