#!/bin/bash

# A Jenkins job script
# Run on every nagios nrpe host

# Predefined const
# $WORKSPACE

cp -rf $WORKSPACE/nagios_nrpe/etc/nagios/nrpe.cfg /etc/nagios/nrpe.cfg
cp -rf $WORKSPACE/nagios_nrpe/usr/lib64/nagios/plugins/* /usr/lib64/nagios/plugins
