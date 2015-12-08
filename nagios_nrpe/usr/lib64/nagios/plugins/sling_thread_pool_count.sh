#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on all sling node
#

queued_count=`curl --max-time 10 -s 'http://127.0.0.1:9999/monitor.threadpool_status?executor_method=getQueue' | tr -d ' \t\n\r'`
if [ $? -ne 0 ]; then
  echo "Something is wrong with sling."
  exit $RET_WR
fi

echo -n "Queued count: $queued_count; "

if [ $queued_count -gt 5 ]; then
  echo "larger than 5"
  exit $RET_CR
elif [ $queued_count -gt 1 ]; then
  echo "larger than 1"
  exit $RET_WR
fi

echo "OK"
exit $RET_OK
