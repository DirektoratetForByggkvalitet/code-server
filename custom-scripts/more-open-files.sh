#!/bin/sh

# echo "Adding sysctl 20-file-max.conf"
# echo "fs.file-max = 2097152" > /etc/sysctl.d/20-file-max.conf
# sysctl -p
ulimit -n -1
exit 0
