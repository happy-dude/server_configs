#!/bin/bash

WEBSRV="www.midco.sa3" #Insert primary web server address here
LOCAL_WEB_DIR=/var/apache2/2.2/htdocs/midco #Set web location here. DO NOT use quotes
#REMOTE_CHAT_DB="webim" #Insert name of chat database
#LOCAL_CHAT_DB="midco_livechat_db"
#DB_USER="hugesync"
#DB_PASSWD="Nnc8F7QocTFjEweAxelE8drBeomDSQvyKR3icRkrqrDLG3t2j8omCHYUAtCl0NB"
#LOCAL_DB_USER="hugesync"
#LOCAL_DB_PASSWD="thisPassForRedundancy"
wget --quiet --mirror http://$WEBSRV -P $LOCAL_WEB_DIR --exclude-directories=/webim


#ssh -i /root/hugesync.privkey hugesync@$WEBSRV mysqldump --user=$DB_USER --password=$DB_PASSWD $REMOTE_CHAT_DB | mysql --user=$LOCAL_DB_USER --password=$LOCAL_DB_PASSWD $LOCAL_CHAT_DB

