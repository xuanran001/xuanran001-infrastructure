#!/bin/bash

SMI_OK=0
SMI_WR=1
SMI_CR=2
SMI_UK=3

SMI="/usr/bin/nvidia-smi"

$SMI &> /dev/null
if [ $? -ne 0 ]; then
  echo "SMI failed: exit code of nvidia-smi is not 0"
  exit $SMI_CR
fi

$SMI | grep "ERROR: GPU is lost" &> /dev/null
if [ $? -eq 0 ]; then
  echo "SMI error: ERROR: GPU is lost: Please reboot this server to fix problem"
  exit $SMI_CR
fi

$SMI | grep "ERR" &> /dev/null
if [ $? -eq 0 ]; then
  echo "SMI error"
  exit $SMI_CR
fi

echo "OK"
exit $SMI_OK
