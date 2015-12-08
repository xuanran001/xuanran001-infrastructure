#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

/bin/rpm -q redis &> /dev/null
if [ $? -ne 0 ]; then
  echo "redis not installed."
  exit $RET_CR
fi

/etc/init.d/redis status
if [ $? -ne 0 ]; then
  echo "service not started"
  exit $RET_CR
fi

exit $RET_OK
