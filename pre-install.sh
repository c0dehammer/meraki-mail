#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get upgrade -y
apt-get install software-properties-common git -y
add-apt-repository ppa:deadsnakes/ppa
apt install python3 -y
apt install python3-pip -y
apt install python3-virtualenv -y
rm -rf ./modoboa-installer
git clone https://github.com/modoboa/modoboa-installer
cp installer.cfg modoboa-installer/
mkdir -p /etc/cron.d/
echo "Etc/UTC" > /etc/timezone
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata
