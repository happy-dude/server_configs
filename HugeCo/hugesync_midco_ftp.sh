#!/bin/bash

FTPSRV="10.111.231.1" #Insert address of remote ftp server
LOCAL_FTP_DIR=/var/ftp/ftpjail/var/ftp/ftpjail/midco #Insert local location of ftp files here. DO NOT use quotes
wget --quiet --mirror ftp://$FTPSRV -P $LOCAL_FTP_DIR --exclude-directories=/westco
