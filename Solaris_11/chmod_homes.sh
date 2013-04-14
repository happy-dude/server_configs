#! /bin/bash

# From http://serverfault.com/questions/440461/script-to-run-chown-on-all-folders-and-setting-the-owner-as-the-folder-name-minu

for dir in /homeShares/*/; do
    # strip trailing slash
    homedir="${dir%/}"
    # strip all chars up to and including the last slash
    username="${homedir##*/}"

    case $username in
    *.*) continue ;; # skip name with a dot in it
    esac

    #cp -R /homeShares/schan-admin/server_configs/Solaris_11/skel/* $dir
    #cp -R /homeShares/schan-admin/server_configs/Solaris_11/skel/.* $dir
    #cp -R /homeShares/schan-admin/server_configs/CentOS_6/skel/.* $dir

    chown -R "$username" "$dir"
    chgrp -R 1000 "$dir"
done
