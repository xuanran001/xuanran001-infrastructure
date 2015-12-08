#!/bin/bash

RET_OK=0
RET_WR=1
RET_CR=2
RET_UK=3

connection_count=`/bin/ps -ef | /bin/grep vsftp | /usr/bin/wc -l`
echo "FTP connections is $connection_count"

if [ $connection_count -gt 20 ]; then
  exit $RET_WR
fi

if [ $connection_count -gt 40 ]; then
  exit $RET_CR
fi

exit $RET_OK
