#!/bin/bash


# 1. Installing Software
# 1.1 LXD
if lxd --version | grep -q '.';  then
    echo "STATUS --------------- lxd ALREADY EXISTS "
else
    sudo snap install lxd
    echo "STATUS --------------- INSTALLATION COMPLETE - LXD"
fi

# 1.2 CURL
if curl --version | grep -q '.'; then
    echo "STATUS --------------- curl ALREADY EXISTS"
else
    sudo apt install curl
    echo "STATUS --------------- INSTALLATION COMPLETE - CURL"
fi

# Getting access to lxd
sudo usermod -a -G lxd student


# 2. Creating Container
if ip a | grep -q 'lxdbr0'; then
    echo "STATUS --------------- LXD ALREADY EXISTS "
else
    lxd init auto
    echo "STATUS --------------- LXD CREATED"
fi

# 2.1 Creating Ubuntu Container
if lxc list | grep -q 'COMP2101-S22 | RUNN'; then
    echo "STATUS --------------- Container ALREADY EXISTS "
else
    lxc launch images:ubuntu/20.04 COMP2101-S22
    # Updating the container files
    lxc exec COMP2101-S22 -- apt update
    lxc exec COMP2101-S22 -- apt upgrade
    echo "STATUS --------------- CONTAINER CREATED"
fi
    

# 3. Installing software in the container
if lxc exec COMP2101-S22 -- apache2 -v | grep -q 'version: Apache/2'; then
    echo "STATUS --------------- Apache2 ALREADY EXISTS "
else
    lxc exec COMP2101-S22 -- apt install apache2
    echo "STATUS --------------- Apache2 INSTALLED "
fi


# GET IP ADDRESS
containerIP=$(lxc list | grep COMP2101-S22 | grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")


# 4. Configuring and populating Web Service
# 5. Testing web service
ipCheck=$(curl -s -I -X GET $containerIP)
if echo "$ipCheck" | grep -q 'Content-Type'; then
    echo "STATUS --------------- STATUS 200 || SUCCESS --> http://$containerIP "
else
    echo "STATUS --------------- SERVER NOT AVAILABLE "
fi

if grep -q "COMP2101-S22" /etc/hosts; then
    echo "STATUS --------------- HOST ALREADY EXISTS"
else
    echo "$containerIP COMP2101-S22" >> /etc/hosts
fi