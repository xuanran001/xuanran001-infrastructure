#!/bin/bash

# Source function library.
. /usr/lib64/nagios/plugins/functions

#
# Check on 0.58 and 0.61
#

# Consistency checking for Nginx config files.
check_diff "xuanran001.com" "/usr/local/nginx/conf/nginx.conf"
#check_diff "xuanran001.com" "/usr/local/nginx/conf/sites-available/xuanran001.com.conf"
#check_diff "xuanran001.com" "/usr/local/nginx/conf/sites-available/feilujiaju.com.conf"

# Mount point exist.
check_mount "/home/glue/share/repository/_mounted_flag_"
check_mount "/var/www/html/upload/_mounted_flag_"

# Check file/dir exist
check_file "/var/www/html/web/index.php"

echo "OK"
exit $RET_OK
