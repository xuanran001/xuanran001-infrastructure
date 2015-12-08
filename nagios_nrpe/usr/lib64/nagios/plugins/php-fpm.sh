#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

/bin/rpm -q php-fpm &> /dev/null
if [ $? -ne 0 ]; then
  echo "package not installed."
  exit $RET_CR
fi

/etc/init.d/php-fpm status
if [ $? -ne 0 ]; then
  echo "service not started"
  exit $RET_CR
fi

exit $RET_OK
