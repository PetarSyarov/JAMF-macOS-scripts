#!/bin/bash

batteryCycleCount=$( ioreg -r -c "AppleSmartBattery" | grep '"CycleCount" = ' | awk '{ print $3 }' | sed s/\"//g )

echo "<result>$batteryCycleCount</result>"