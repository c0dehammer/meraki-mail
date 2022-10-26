#!/bin/bash

#sed -i "0,/mail.localhost/ s/mail.localhost/${DOMAIN}/" /etc/postfix/main.cf
#sed -i "0,/mail.localhost/ s/mail.localhost/${DOMAIN}/" /etc/amavis/conf.d/05-node_id
#sed -i "s/server_name mail.localhost/server_name ${DOMAIN}/g" /etc/nginx/sites-enabled/mail.localhost.conf
#domain=${DOMAIN}
#domain=$(expr match "$domain" '.*\.\(.*\..*\)')
#sed -i "s/server_name autoconfig.localhost/server_name autoconfig.${domain}/g" /etc/nginx/sites-enabled/autoconfig.localhost.conf


export PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[0:2])))')
export PYTHON_VERSION="python"$PYTHON_VERSION




CONTAINER_FIRST_STARTUP="CONTAINER_FIRST_STARTUP"
if [ ! -e /$CONTAINER_FIRST_STARTUP ]; then
    touch /$CONTAINER_FIRST_STARTUP
    #place your script that you only want to run on first startup.
    modoboa-installer/run.py --debug --force merakisystems.com
    echo "starting post install"
    cd /installer
    ./post-install.sh
    echo "finished post install"
else
    # script that should run the rest of the times (instances where you 
    # stop/restart containers).
        
    # fix manage.py not working
    #  adding path
    export PYTHONPATH=/srv/modoboa/env/lib/$PYTHON_VERSION/site-packages
    
    # starting policy daemon. else we need to disable main.cf 9999 referenced service
    /srv/modoboa/instance/manage.py policy_daemon
    
    #starting services which would have typically been started via systemctl

    services=("cron" "syslog-ng" "supervisor" "postgresql" "nginx" "uwsgi" "dovecot" "postfix" "redis-server" "amavis" "opendkim" "clamav-daemon")

    for service in ${services[@]}; do
      service ${service} start
    done

    tail -f /dev/null
fi




