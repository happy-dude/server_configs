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

#Location of backup logs
LOG_DIR="/backups/logs"

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

    # Define rsync options
    HOME_OPTS="-avh --delete --log-file=$LOG_DIR/homeShares-$TODAY.log"
    OU_OPTS="-avh --delete --log-file=$LOG_DIR/ouShares-$TODAY.log"

    # Execute rsync to backup homeShares and ouShares
    $RSYNC $HOME_OPTS $HOMES_DIR $HOMES_BACK
    $RSYNC $OU_OPTS $OU_DIR $OU_BACK

    # Compress the full backup for transfer to remote server
    TAR="/bin/tar"
    TAR_OPTS="-jpcvf"
    $TAR $TAR_OPTS "$OU_BACK.tar.bz2" $OU_DIR
    $TAR $TAR_OPTS "$HOMES_BACK.tar.bz2" $HOMES_DIR

    # Define mount path and options; mount the remote NFS share
    MOUNT="/sbin/mount"
    MOUNT_OPTS="-F nfs -o rw,vers=3"
    TOP_NFS="top.sa3:/home/eastco"
    MOUNT_PATH="/top"
    $MOUNT $MOUNT_OPTS $TOP_NFS $MOUNT_PATH

    # Switch to topper (UID 503) to copy over the archive to remote
    SU="/bin/su"
    COPY="/usr/bin/cp"
    COPY_OPTS="-rp"
    $SU - topper -c "$COPY $COPY_OPTS $HOMES_BACK.tar.bz2 $MOUNT_PATH/homeShares/"
    $SU - topper -c "$COPY $COPY_OPTS $LOG_DIR/homeShares-$TODAY.log $MOUNT_PATH/logs/"
    $SU - topper -c "$COPY $COPY_OPTS $OU_BACK.tar.bz2 $MOUNT_PATH/ouShares/"
    $SU - topper -c "$COPY $COPY_OPTS $LOG_DIR/ouShares-$TODAY.log $MOUNT_PATH/logs/"

    UMOUNT="/usr/sbin/umount"
    $UMOUNT $MOUNT_PATH

else

    #echo "Today is not Sunday!"

    # Define rsync options
    HOME_OPTS="-avh --delete --link-dest=$HOME_PREV --log-file=/backups/logs/homeShares-$TODAY.log"
    OU_OPTS="-avh --delete --link-dest=$OU_PREV --log-file=/backups/logs/ouShares-$TODAY.log"

    # Execute rsync to backup homeShares and ouShares
    $RSYNC $HOME_OPTS $HOMES_DIR $HOMES_BACK
    $RSYNC $OU_OPTS $OU_DIR $OU_BACK
fi
