meraki-mail

add the following to the host 

# set outgoing IP address, if hosted on a multi ip host
# sudo iptables -t nat -I POSTROUTING -p all -s 172.22.0.0/16 -j SNAT --to -source xxx.xxx.xxx.xxx

-> 172.22.0.0/16 is the docker container network

-> xxx.xxx.xxx.xxx is the outgoing ip that should be used
