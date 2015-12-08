#!/bin/bash
date=`date +%s`
checkfile=/var/www/html/upload/test.txt
echo $date > $checkfile
localmd5=`md5sum $checkfile|cut -b -5`
sleep 3
        Md5=`md5sum /mnt/upload/test.txt|cut -b -5`
if [  $localmd5 == $Md5  ]; then
        echo "upload point is healthy"
		exit 0
else
        echo "upload point is CRITICAL"
		exit 2
fi                                     
