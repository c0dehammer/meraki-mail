#!/bin/bash

PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[0:2])))')
PYTHON_VERSION="python"$PYTHON_VERSION

sed -i '0,/pidfile=/ s/pidfile=/pidfile=\$PIDFILE/' /etc/init.d/opendkim
sed -i '0,/dnsbl.sorbs.net/ s/dnsbl.sorbs.net/#dnsbl.sorbs.net/' /etc/postfix/main.cf
sed -i '0,/postscreen_bare_newline_enable = yes/ s/postscreen_bare_newline_enable = yes/postscreen_bare_newline_enable = no/' /etc/postfix/main.cf
sed -i '0,/postscreen_non_smtp_command_enable = yes/ s/postscreen_non_smtp_command_enable = yes/postscreen_non_smtp_command_enable = no/' /etc/postfix/main.cf
sed -i '0,/postscreen_pipelining_enable = yes/ s/postscreen_pipelining_enable = yes/postscreen_pipelining_enable = no/' /etc/postfix/main.cf
sed -i '0,/mail.localhost/ s/mail.localhost/\*/' /srv/modoboa/instance/instance/settings.py
# caldav issue https://github.com/modoboa/modoboa/issues/2571#issuecomment-1210003862
sed -i 's/username=username, password=password)/username=username, password=password, ssl_verify_cert=False)/' /srv/modoboa/env/lib/$PYTHON_VERSION/site-packages/modoboa_radicale/backends/caldav_.py
# emails not being sent or received
sed -i 's/check_policy_service/# check_policy_service/' /etc/postfix/main.cf
# manage.py not working
export PYTHONPATH=/srv/modoboa/env/lib/$PYTHON_VERSION/site-packages
