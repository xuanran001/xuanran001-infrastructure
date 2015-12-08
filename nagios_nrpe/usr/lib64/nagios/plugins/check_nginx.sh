#!/bin/bash

RET_OK=0
RET_WR=1
RET_CR=2
RET_UK=3

CURL="/usr/bin/curl"

# nrpe timeout is 10s
$CURL --max-time 4 -F"foo=bar" http://www.xuanran001.com:88/userdata/user/update
xuanran001_ret=$?

$CURL --max-time 4 -F"foo=bar" http://www.feilujiaju.com:88/userdata/user/update
feilujiaju_ret=$?

if [ $xuanran001_ret -eq 52 ]; then
  echo "curl(52): Failed to post request to nginx(xuanran001.com), bug:14711"
  exit $RET_CR
fi

if [ $xuanran001_ret -eq 56 ]; then
  echo "curl(56): Failed to post request to nginx(xuanran001.com), bug:14711"
  exit $RET_CR
fi

if [ $feilujiaju_ret -eq 52 ]; then
  echo "curl(52): Failed to post request to nginx(feilujiaju.com), bug:14711"
  exit $RET_CR
fi

if [ $xuanran001_ret -eq 7 ]; then
  echo "curl(7): Couldn't connect to host(xuanran001.com), maybe nginx is stopped."
  exit $RET_CR
fi

if [ $xuanran001_ret -eq 28 ]; then
  echo "curl(28): Failed to post request to nginx(xuanran001.com), 9s timeout."
  exit $RET_CR
fi

if [ $xuanran001_ret -ne 0 ]; then
  echo "curl($xuanran001_ret): Failed to post request to nginx(xuanran001.com), unknown error."
  exit $RET_WR
fi

echo "OK"
exit $RET_OK
