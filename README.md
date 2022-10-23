MOdoboa based email server 

just run the compose file on portainer, and restart after first run. 

add the following to the host 

# set outgoing IP address, if hosted on a multi ip host
# sudo iptables -t nat -I POSTROUTING -p all -s 172.22.0.0/16 -j SNAT --to -source xxx.xxx.xxx.xxx

-> 172.22.0.0/16 is the docker container network

-> xxx.xxx.xxx.xxx is the outgoing ip that should be used



Incase lets encrypt requests have crossed the threshold (add more domains to create a new certificate request)


certbot certonly -d mail.xx.com -d xx.xx.com

