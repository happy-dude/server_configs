#
# Copyright (c) 1991, 2012, Oracle and/or its affiliates. All rights reserved.
#
umask 022
set path=(/usr/bin /usr/sbin)
if ( $?prompt ) then
	set history=32
endif
