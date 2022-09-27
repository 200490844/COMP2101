#!/bin/bash

echo "Report for myvm"
echo "==============="
# username
fqDomainName=$(hostname --fqdn)
echo "FQDN: $fqDomainName"
# os information               
operatingSystemInfo=$(hostnamectl | grep -h "Operating" | awk '{printf $3 $4 $5}')
echo "Operating System name and version: $operatingSystemInfo"
# System IP Address       
ipInfo=$(ip a | grep global | awk '{print $2}')
echo "IP Address: $ipInfo"
# Storage Information
freeSpace=$(df -h / | grep "/sda" | awk '{print $4}')  
echo "Root Filesystem Free Space: $freeSpace"
echo "==============="