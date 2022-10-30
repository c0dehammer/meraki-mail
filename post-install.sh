#!/bin/bash

export PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[0:2])))')
export PYTHON_VERSION="python"$PYTHON_VERSION
# manage.py not working
#  adding path
export PYTHONPATH=/srv/modoboa/env/lib/$PYTHON_VERSION/site-packages

sed -i '0,/pidfile=/ s/pidfile=/pidfile=\$PIDFILE/' /etc/init.d/opendkim
sed -i '0,/dnsbl.sorbs.net/ s/dnsbl.sorbs.net/#dnsbl.sorbs.net/' /etc/postfix/main.cf
sed -i '0,/postscreen_bare_newline_enable = yes/ s/postscreen_bare_newline_enable = yes/postscreen_bare_newline_enable = no/' /etc/postfix/main.cf
sed -i '0,/postscreen_non_smtp_command_enable = yes/ s/postscreen_non_smtp_command_enable = yes/postscreen_non_smtp_command_enable = no/' /etc/postfix/main.cf
sed -i '0,/postscreen_pipelining_enable = yes/ s/postscreen_pipelining_enable = yes/postscreen_pipelining_enable = no/' /etc/postfix/main.cf
sed -i '0,/mail.localhost/ s/mail.localhost/\*/' /srv/modoboa/instance/instance/settings.py


#      - dkim:/var/lib/dkim
#      - vmail:/srv/vmail
#      - psql:/var/lib/postgresql/14/main
#      - ssl:/etc/ssl/
#      - letsencrypt:/etc/letsencrypt/
#      - radicale-collections:/srv/radicale/
#      - radicale-rights:/etc/radicale/

chown -R opendkim:opendkim /var/lib/dkim
chown -R vmail:vmail /srv/vmail
chown -R postgres:postgres /var/lib/postgresql
chown -R root:ssl-cert /etc/ssl
chown -R root:root /etc/letsencrypt
chown -R radicale:radicale /srv/radicale
chown -R radicale:radicale /etc/radicale

# caldav issue https://github.com/modoboa/modoboa/issues/2571#issuecomment-1210003862
sed -i 's/username=username, password=password)/username=username, password=password, ssl_verify_cert=False)/' /srv/modoboa/env/lib/$PYTHON_VERSION/site-packages/modoboa_radicale/backends/caldav_.py

#  changing interpreter to python3 . dont think this is required
# sed -i 's/env python/env python3/' /srv/modoboa/instance/manage.py


# emails not being sent or received
#  this was due to policy service not starting. either remove the dependency of policy service from postfix, such as below. 
# sed -i 's/check_policy_service/# check_policy_service/' /etc/postfix/main.cf


echo "** post-install.sh has finished running..."
