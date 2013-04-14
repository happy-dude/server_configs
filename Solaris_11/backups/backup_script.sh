#!/bin/bash

# rsync Test Backup Script
# Skeleton from http://webgnuru.com/linux/rsync_incremental.php and http://www.mikerubel.org/computers/rsync_snapshots/

#Todays date in ISO-8601 format:
TODAY=`/usr/gnu/bin/date -I`

#Yesterdays date in ISO-8601 format:
YESTERDAY=`/usr/gnu/bin/date -I -d "1 day ago"`

#The source directories:
#SRC="/var/www/htdocs/"
HOMES_DIR="/homeShares/"
OU_DIR="/ouShares/"

#The target directories:
#TRG="/backup/website/$DAY0"
HOMES_BACK="/backups/homeShares/$TODAY"
OU_BACK="/backups/ouShares/$TODAY"

#The link destination directories:
#LNK="/backup/website/$DAY1"
HOME_PREV="/backups/homeShares/$DAY1"
OU_PREV="/backups/ouShares/$DAY1"

#Define the absolute path for rsync
RSYNC="/opt/csw/bin/rsync"

# Options are defined in the if-else block
#The rsync options:
#OPT="-avh --delete --link-dest=$LNK"
#HOME_OPTS="-avh --delete --link-dest=$HOME_PREV --log-file=/backups/logs/homeShares-$TODAY.log"
#OU_OPTS="-avh --delete --link-dest=$OU_PREV --log-file=/backups/logs/ouShares-$TODAY.log"

#Execute the backup
#rsync $OPT $SRC $TRG

# Check if today is Sunday
if [[ $(/usr/gnu/bin/date +%u) -eq 7 ]]; then

	#echo "Today is Sunday"
	# Mount the fileshares as NFS
	# Redefine HOMES_BACK OU_BACK here to the filesystem

	HOME_OPTS="-avh --delete --log-file=/backups/logs/homeShares-$TODAY.log"
	OU_OPTS="-avh --delete --log-file=/backups/logs/ouShares-$TODAY.log"

	$RSYNC $HOME_OPTS $HOMES_DIR $HOMES_BACK
	$RSYNC $OU_OPTS $OU_DIR $OU_BACK

        # tar.bz2 them up?
        # FTP them over?
	# Unmount the fileshares

else

	#echo "Today is not Sunday!"
	HOME_OPTS="-avh --delete --link-dest=$HOME_PREV --log-file=/backups/logs/homeShares-$TODAY.log"
	OU_OPTS="-avh --delete --link-dest=$OU_PREV --log-file=/backups/logs/ouShares-$TODAY.log"

	$RSYNC $HOME_OPTS $HOMES_DIR $HOMES_BACK
	$RSYNC $OU_OPTS $OU_DIR $OU_BACK
fi
