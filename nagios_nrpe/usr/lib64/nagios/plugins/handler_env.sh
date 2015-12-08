#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on all handlers
#

# Must setup handler using stardard script (kickstart), otherwise some problem may occur.
if [ -f /root/ks-finished.txt ];then
  echo "Not installed by kickstart or kickstart post-script."
  exit $RET_CR
fi

# MUST disable selinux
check_selinux

# Consistency checking for Nginx config files.
check_diff "handler" "/etc/hosts"

# Mount point exist.
check_mount "/home/glue/share/repository/_mounted_flag_"

# Check file/dir exist
check_file "/var/local/blender-2.72b-linux-glibc211-x86_64/blender"
check_file "/opt/jp2a-1.0.6/src/jp2a"
check_file "/usr/java/jdk1.8.0_05/bin/java"
# TODO(d3vin.chen@gmail.com): nrpe process can not access these files.
#check_file "/root/.ssh/id_rsa"
#check_file "/root/.ssh/id_dsa"
#check_file "/root/.ssh/id_dsa.pub"
check_file "/opt/gmic_static_linux64/gmic"

# Check installed package
check_rpm "gimp"
check_rpm "subversion"
check_rpm "lm_sensors"
check_rpm "glusterfs-fuse"

# Check hostname
IPADDR="`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}' | awk 'BEGIN{FS="."}{print $4}'`"
hostname="XR$IPADDR"
grep "$hostname" /etc/sysconfig/network &> /dev/null
if [ $? -ne 0 ];then
  echo "hostname is not $hostname"
  exit $RET_WR
fi

echo "OK"
exit $RET_OK
