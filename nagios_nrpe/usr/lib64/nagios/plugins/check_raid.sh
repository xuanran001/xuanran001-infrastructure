#!/bin/sh
#cat /pro/mdstat |grep F
grep F /proc/mdstat >/dev/null
a=`echo $?`
grep \_ /proc/mdstat >/dev/null
b=`echo $?`
if [ $a -eq 0 ];then
   echo "CRITICAL - Raid Error.Code : "F" disk off raid  "
   exit 2
fi
if [ $b -eq 0 ];then
   echo "WARNING - Raid Warning.Code : "_U" recovery  "
   exit 1
fi
echo "OK - Raid is ok"
exit 0
