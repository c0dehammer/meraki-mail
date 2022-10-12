#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get install software-properties-common git -y
add-apt-repository ppa:deadsnakes/ppa
apt install python3 -y
apt install python3-virtualenv -y
git clone https://github.com/modoboa/modoboa-installer
mkdir -p /etc/cron.d/

