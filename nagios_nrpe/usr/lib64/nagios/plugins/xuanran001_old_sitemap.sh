#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on 0.61 (may 0.58 too)
#

# TODO(d3vin.chen@gmail.com): Check all sitemap files
file="/var/www/html/web/sitemap.xml.gz"

current=`date +%s`
last_modified=`stat -c "%Y" $file`

# Not update sitemap for 10 days.
# 10days => 720,000
if [ $(($current-$last_modified)) -gt 720000 ]; then
  echo "Sitemap file is old than 10ays!"
  exit $RET_WR
fi

echo "OK"
exit $RET_OK
