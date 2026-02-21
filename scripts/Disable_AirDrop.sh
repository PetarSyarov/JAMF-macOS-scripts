#!/bin/bash


/usr/bin/defaults write /Library/Preferences/com.apple.NetworkBrowser DisableAirDrop -bool YES

/usr/bin/killall Finder

if [ $? -eq 0 ]; then
     echo "Successfully disabled AirDrop and restarted Finder."
     exit 0
 else
     echo "Failed to disable AirDrop or restart Finder."
     exit 1
fi