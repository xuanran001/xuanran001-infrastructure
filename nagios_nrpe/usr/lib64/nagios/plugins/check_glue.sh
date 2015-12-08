#!/bin/sh
KEY="4r5qEZIEr6YvckPHcWuMBcQqqXIC1M5f"
/usr/bin/curl --max-time 60 127.0.0.1:8080/health.html &> /tmp/check_glue
ret=`sed -n 4p /tmp/check_glue`
    if [ "X$ret" = "X$KEY" ]
    then
        echo " OK - glue is ok "
        exit 0
    else
        echo "CRITICAL - glue is wrong"
        exit 2
    fi