#!/usr/bin/env python
import os
import sys
NPM_OK = 0
NPM_WR = 1
NPM_CR = 2
NPM_UK = 3
output = os.popen("ps aux | grep node | grep -v grep")
output = output.readlines()
if len(output) == 0:
  print "node is stop"
  os.system('curl "http://192.168.2.21:8080/job/chenyang_notification/buildWithParameters?token=sp12345678&title=npm_down&content=npm_down"')
  sys.exit(NPM_CR)
else:
  print "node is running"
  sys.exit(NPM_OK)
