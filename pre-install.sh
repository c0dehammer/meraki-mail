#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get upgrade -y
apt-get install software-properties-common git -y

# for backward compatibility on python versions
##add-apt-repository ppa:deadsnakes/ppa
##apt install python3 -y
##apt install python3-pip -y
##apt install python3-virtualenv -y
apt install nano curl iputils-ping -y

# /var/log/mail.log depends on a syslog daemon. docker ubuntu does not have the ability to run rsyslog due to lack of systemctl. so we need to install syslog-ng. 
apt install syslog-ng -y

# the normal postgres install script within run.py doesnt seem to work sometimes
apt install postgresql postgresql-contrib -y

# get fresh modoboa installer from official repo
rm -rf ./modoboa-installer
git clone https://github.com/modoboa/modoboa-installer

# copy our standard config requirements. we dont need to do this because of the sed functions implemented
# if we dont keep the same creds, recovery is going to be harder
# for fresh with better security check the following line. for easy recovery, uncheck
cp installer.cfg modoboa-installer/

# virtual systems without systemd etc needs a cron job to be added
mkdir -p /etc/cron.d/

# time zone section to be done at this stage, else it will create a popup for user input, breaking the Dockerfile image compilation 
echo ${TIMEZONE} > /etc/timezone
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata

# echo "127.0.0.1 database" >> /etc/hosts

# apt-get install virtualenv python3-pip
# useradd modoboa  # create a dedicated user
# su -l modoboa    # log in as the newly created user
# virtualenv --python python3 ./env  # create the virtual environment
#source ./env/bin/activate          # activate the virtual environment
