#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on 0.61 only
#

# Consistency checking for hosts
check_diff "xuanran001.com" "/etc/hosts"

echo "OK"
exit $RET_OK
