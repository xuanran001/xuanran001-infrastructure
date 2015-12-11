#!/bin/sh

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on all gluenode
#

MAINT_FLAG="/home/glue/weihuzhong.txt"

# Backup sling dir now.
BACKUP_FLAG="/tmp/backup_sling_dir.flag"

if [ -f $MAINT_FLAG ]; then
  echo "Under maintainence."
  exit $RET_OK
fi

if [ -f $BACKUP_FLAG ]; then
  echo "Backup sling dir now."
  exit $RET_OK
fi

/etc/init.d/gluenode status &> /dev/null
RET=$?

if [ $RET -eq 3 ]; then
  echo "CRITICAL - service is stopped."
  exit $RET_CR
fi

if [ $RET -eq 0 ]; then
  echo "OK - service is running."
  exit $RET_OK
fi
