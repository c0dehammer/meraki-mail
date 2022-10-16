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

# apt-get install virtualenv python3-pip
# useradd modoboa  # create a dedicated user
# su -l modoboa    # log in as the newly created user
$ virtualenv --python python3 ./env  # create the virtual environment
$ source ./env/bin/activate          # activate the virtual environment
