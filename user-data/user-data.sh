#!/bin/bash
# This script is meant to be run in the User Data of an EC2 Instance while it's booting.
set -e

# Send the log output from this script to user-data.log, syslog, and the console
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "echo " >> /tmp/sys_info.sh
echo "sudo dmidecode | grep -A3 'System Information'" >> /tmp/sys_info.sh
echo "echo " >> /tmp/sys_info.sh
echo "free -h" >> /tmp/sys_info.sh
echo "echo " >> /tmp/sys_info.sh
echo "lscpu |sed -n '4P'" >> /tmp/sys_info.sh
echo "echo " >> /tmp/sys_info.sh
echo "echo -n "OS Version:   " ; uname -a" >> /tmp/sys_info.sh
echo "echo " >> /tmp/sys_info.sh
chmod +x /tmp/sys_info.sh
