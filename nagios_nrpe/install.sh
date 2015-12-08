#!/bin/bash

# A Jenkins job script
# Run on every nagios nrpe host

# Predefined const
# $WORKSPACE

cp -rf $WORKSPACE/nagios_nrpe/etc/nagios/nrpe.cfg /etc/nagios/nrpe.cfg
cp -rf $WORKSPACE/nagios_nrpe/usr/lib64/nagios/plugins/* /usr/lib64/nagios/plugins

cat /etc/centos-release | grep 7\.0
if [ $? -eq 0 ]; then
  systemctl restart nrpe.service
else
  /etc/init.d/nrpe reload
fi
