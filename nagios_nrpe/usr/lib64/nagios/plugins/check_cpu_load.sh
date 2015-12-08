#!/bin/sh

# Source function library.                                                       
. /usr/lib64/nagios/plugins/functions 

###get   cpu   load average####
#cpu_uptiem   one mint load
#cpu_uptiem=`uptime|awk '{print $12}'`
cpu_uptiem=`uptime | awk -F 'load average: ' '{print $2}'|awk -F "," '{print $3}'`
cpu_num=`grep 'model name' /proc/cpuinfo | wc -l`
#echo $cpu_uptiem
#echo $cpu_num
cpu_load=`echo $cpu_uptiem  $cpu_num |awk '{print $1/$2}'`
#echo $cpu_load

warning_level=1.1
critial_level=1.2

if [ `echo "$cpu_load <= $warning_level" | bc` -eq 1 ];then
	echo "OK - CPU load average is  $cpu_load"
	exit $RET_OK
fi

if [ `echo "$cpu_load <= $critial_level" | bc` -eq 1 ];then
	echo "WARNING - CPU load average is  $cpu_load"
	exit $RET_WR
fi

if [ `echo "$cpu_load > $critial" | bc` -eq 1 ];then
	echo "CRITICAL  - CPU load average is  $cpu_load"
	exit $RET_CR
fi

echo "Unkonwn error!"
