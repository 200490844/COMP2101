#!/bin/bash

echo "*********************************"

# hostname/username data command
echo "HOSTNAME: $(hostname)"

echo "*********************************"

# hostnamectl - big information
echo "HOSTNAMECTL:"
hostnamectl

echo "*********************************"

# operating system information command
osInformation=$(hostnamectl | grep -h "Operating")
echo "$osInformation"

echo "*********************************"

# internet protocol information with "grep"
echo "IP INFORMATION: "
ip a | grep -h "inet"

echo "*********************************"

# memory information only for root directories
echo "STORAGE SPACE DATA: "
memory=$(df | grep -h "/dev/")
echo "$memory"

echo "*********************************"