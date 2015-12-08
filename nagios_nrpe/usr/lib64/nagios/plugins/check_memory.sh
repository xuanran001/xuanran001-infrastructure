#!/bin/bash
#echo "$1"
free=`free -g |grep Mem|awk '{print $2}'`
free_m=`free -m |grep Mem|awk '{print $2}'`
#echo "$free"
if [ $free -eq $1 ]
then
echo " OK - The Memory is $free_m M "
exit 0
fi

if  [ $1 -gt $free ]
then
echo " CRITICAL - The Memory is $free_m M,lower than $1 G "
exit 2
fi

if  [ $free -gt $1 ]
then
echo " WARNING - The Memory is $free_m M,more than the value you set $1 G,so please change your set "
exit 2
fi
