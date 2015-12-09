#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

FLAG="/tmp/nginx_is_restarting_now"

# Nginx is restarted every night.
# Do not warning this job.
if [ -f $FLAG ]; then
  echo $FLAG
  exit $RET_OK
fi

/etc/init.d/nginx status &> /dev/null
nginx_status=$?

if [ $nginx_status -eq 3 ]; then
  echo "Nginx service is stopped, please start nginx, or add to chkconfig."
  exit $RET_CR
fi

if [ $nginx_status -ne 0 ]; then
  echo "Something is wrong with nginx, exit code is $nginx_status"
  exit $RET_WR
fi

echo "OK"
exit $RET_OK
