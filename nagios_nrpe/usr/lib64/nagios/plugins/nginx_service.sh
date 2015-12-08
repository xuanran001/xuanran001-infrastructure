#!/bin/bash

RET_OK=0
RET_WR=1
RET_CR=2
RET_UK=3

/etc/init.d/nginx status &> /dev/null
RET=$?

if [ $RET -eq 3 ]; then
  echo "Nginx service is stopped, please start nginx, or add to chkconfig."
  exit $RET_CR
fi

if [ $RET -ne 0 ]; then
  echo "Something is wrong with nginx, exit code is $RET"
  exit $RET_WR
fi

echo "OK"
exit $RET_OK
