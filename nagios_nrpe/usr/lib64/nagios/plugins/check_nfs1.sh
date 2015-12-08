#!/bin/bash
date=`date +%s`
checkfile=/home/glue/sling/jackrabbit/repository/datastore/test.txt
echo $date > $checkfile
localmd5=`md5sum $checkfile|cut -b -5`
sleep 3
        Md5=`md5sum /mnt/datastore/test.txt|cut -b -5`
if [  $localmd5 == $Md5  ]; then
        echo "datastore point is healthy"
		exit 0
else
        echo "datastore point is CRITICAL"
		exit 2
fi
