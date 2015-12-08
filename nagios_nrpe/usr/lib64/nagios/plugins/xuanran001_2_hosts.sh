#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on 0.58 only
#

# Consistency checking for hosts
check_diff "xuanran001_2" "/etc/hosts"

echo "OK"
exit $RET_OK
