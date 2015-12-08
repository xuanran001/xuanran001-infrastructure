#!/bin/bash
#echo "$1"
#free=`free -g |grep Mem|awk '{print $2}'`                  #Real memory 
less_memory=100
free_m=`free -m |grep Mem|awk '{print $2}'`				#Real memory with M
free_m_used=`free -m |grep Mem|awk '{print $3}'`
free_mem=`free -m |grep Mem|awk '{print $4}'`				#free_mem means real free memory  with M
#echo "$free"
# if [ $free_mem -eq $1 ]
# then
# echo " OK - The Memory is $free_m M "
# exit 0
# fi

# if  [ $1 -gt $free ]
# then
# echo " CRITICAL - The Memory is $free_m M,lower than $1 G "
# exit 2
# fi

# if  [ $free -gt $1 ]
# then
# echo " WARNING - The Memory is $free_m M,more than the value you set $1 G,so please change your set "
# exit 2
# fi
if [ ! $free_mem -gt $less_memory ]
then
echo " WARNING -  Free memory is less than $less_memory M. Free memory is $free_mem M. "
exit 1
else
echo " OK - Total Memory is $free_m M, $free_m_used M used,$free_mem M free."
exit 0
fi
