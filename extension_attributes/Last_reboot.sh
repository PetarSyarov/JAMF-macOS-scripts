#!/bin/bash

bootTime=$(sysctl kern.boottime | awk '{print $5}' | tr -d ,)
formattedTime=$(date -jf %s $bootTime "+%F %T")

echo "<result>${formattedTime}</result>"

exit 0