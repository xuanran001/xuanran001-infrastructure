#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on all gluenode
#

# /opt/glue/check_sling/gluenode-restart.sh will create this flag just before
# stopping sling service. Sling will remove this flag on service is started.
RESTART_FLAG="/tmp/glue-service-is-restarting-now"
# This flag is create by maintenance guy.
MAINT_FLAG="/home/glue/weihuzhong.txt"

if [ -f $MAINT_FLAG ]; then
  echo "Under maintainence."
  exit $RET_OK
fi

if [ -f $RESTART_FLAG ]; then
  echo "Sling is restarting."
  exit $RET_OK
fi

# Check sling service status

http_code="`curl --max-time 9 -s -o /dev/null -w '%{http_code}' 127.0.0.1:9999/.explorer.html`"
curl_ret=$?

if [ $curl_ret -ne 0 ]; then
  echo "curl($curl_ret): Something is wrong with Sling."
  exit $RET_CR
fi

if [ "X$http_code" != "X200" ]; then
  echo "http status($http_code), something is wrong with Sling."
  exit $RET_CR
fi

# Check PUT failed on sling.

# TODO(d3vin.chen@gmail.com): Disable this checking
exit $RET_OK

# Last request finished?
grep "PUT.*log.GET.esp.*wait" /opt/glue/monitor/jstack_dump.txt &> /dev/null
if [ $? -eq 0 ]; then
  echo "Last PUT request (to upload) log.GET.esp is not finished yet."
  exit $RET_WR
fi

svn export $SVNOPT http://$GLUEIP/svn/glue/trunk/bundle/xuanran001/src/main/resources/initial-content/apps/sysop/demo/log.GET.esp /tmp/log.GET.esp &> /dev/null

# nrpe default timeout is 10s
# Request type is PUT
curl --max-time 9 -u admin:admin -T /tmp/log.GET.esp 127.0.0.1:9999/apps/sysop/demo/log.GET.esp &> /dev/null
ret=$?
if [ $ret -eq 28 ]; then
  echo "curl(28): failed to PUT to sling, timeout!"
  exit $RET_WR
elif [ $ret -eq 7 ]; then
  echo "curl(7): Couldn't connect to host, maybe sling is stopped."
  exit $RET_CR
elif [ $ret -ne 0 ]; then
  echo "curl($ret): failed to PUT to sling, unkown reason!"
  exit $RET_CR
fi

echo "OK"
exit $RET_OK
