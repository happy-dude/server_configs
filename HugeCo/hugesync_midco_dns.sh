#!/bin/bash

if [ -e /var/named/no_pull ]
    then
	exit 1
fi

REMOTE_MASTER="10.111.231.1" #fill in address of primary master name server
# space-separated list of zone files
ZONEFILES="/var/named/master/ext-midco.sa3.zone /var/named/master/ext-midco.hugeco.sa3.zone /var/named/master/ext-midco.231.sa3.rev" #fill in absoloute path of zone files you want to pull on primary master
# directory where public site is stored

# we rely on the remote master doing an RNDC flush at least every 5 minutes
rndc freeze
rsync -avz -e "ssh -i /root/hugesync.privkey -l hugesync" hugesync@$REMOTE_MASTER:"$ZONEFILES" /var/named/failover_masters/
rndc thaw

