#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on all gluenode(sling node)
#

# Must setup handler using stardard script (kickstart), otherwise some problem may occur.
if [ -f /root/ks-finished.txt ];then
  echo "Not installed by kickstart or kickstart post-script."
  exit $RET_CR
fi

# MUST disable selinux
check_selinux

# Consistency checking for Nginx config files.
check_diff "gluenode" "/etc/hosts"

# Mount point exist.
check_mount "/home/glue/share/repository/_mounted_flag_"

# Check file/dir exist
check_file "/usr/java/jdk1.6.0_45/bin/java"
check_file "/var/local/blender-2.72b-linux-glibc211-x86_64/blender"

# Check installed package
check_rpm "subversion"
check_rpm "glusterfs-fuse"

# Check hostname
IPADDR="`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}' | awk 'BEGIN{FS="."}{print $4}'`"
hostname="gluenode$IPADDR"
grep "$hostname" /etc/sysconfig/network &> /dev/null
if [ $? -ne 0 ];then
  echo "hostname is not $hostname"
  exit $RET_WR
fi

# Check apache uid and gid
APACHE_UID="`/usr/bin/id -u apache`"
if [ "X$APACHE_UID" != "X48" ]; then
  echo "uid of apache is not 48"
  exit $RET_CR
fi
APACHE_GID="`/usr/bin/id -g apache`"
if [ "X$APACHE_GID" != "X48" ]; then
  echo "gid of apache is not 48"
  exit $RET_CR
fi

echo "OK"
exit $RET_OK
