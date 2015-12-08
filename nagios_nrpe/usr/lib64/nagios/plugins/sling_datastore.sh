#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on 0.60 only
# This job will take some time, so DON'T run job too often.
# Maybe 30min per job will be OK.
#

svnopt=" --username=ci --password=sp12345678 --no-auth-cache --non-interactive "
glueip="192.168.1.153"
espdump="/tmp/esp_file_list.txt"

# This action will take few seconds.
svn list -R $svnopt http://$glueip/svn/glue/trunk/bundle/xuanran001/src/main/resources/initial-content/apps/ > $espdump

while read -r line;
do
  url="http://127.0.0.1:9999/apps/${line}"

  # Not a esp file
  echo $url | grep "/$" &> /dev/null
  if [ $? -eq 0 ]; then
    continue
  fi

  http_code="`curl --max-time 5 -I -s -o /dev/null -w '%{http_code}' $url`"
  if [ "X$http_code" != "X200" ]; then
    echo "$http_code : $url"
    exit $RET_CR
  fi
done < $espdump

echo "OK"
exit $RET_OK
