#!/bin/bash

# Disable AirDrop system-wide
/usr/bin/defaults write /Library/Preferences/com.apple.NetworkBrowser DisableAirDrop -bool YES

# Restart Finder to apply changes immediately
/usr/bin/killall Finder

# Log success or failure
if [ $? -eq 0 ]; then
     echo "Successfully disabled AirDrop and restarted Finder."
     exit 0
 else
     echo "Failed to disable AirDrop or restart Finder."
     exit 1
fi