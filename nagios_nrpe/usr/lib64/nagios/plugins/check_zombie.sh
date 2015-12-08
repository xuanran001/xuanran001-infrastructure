#!/bin/sh
#ps -A -o stat,ppid,pid,cmd | grep -e '^[Zz]' | awk '{print $2}' | xargs kill -9||exit 0;  ]
## 
count_zombie=`ps -A -o stat,ppid,pid,cmd | grep -e '^[Zz]'|grep blender|wc -l `

#echo "$count_zombie"
if [ $count_zombie -eq 0 ]
then
  echo " OK - Zombie_process is not exist "
  exit 0;
fi

if [ $count_zombie -gt 0 ]
then
  curl "http://192.168.2.21:8080/job/chenyang_notification/buildWithParameters?token=sp12345678&title=npm_down&content=npm_down"
  echo "CRITICAL - Zombie_process(blender) is  exist  "
  exit 2
fi
