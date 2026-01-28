#!/bin/zsh

# disk image
(arch -arm64 true && ! arch -x86_64 true) &> /dev/null && softwareupdate --install-rosetta --agree-to-license 2> /dev/null | grep -v this

 
fileURL="https://content.lansweeper.com/lsagent-mac/"

# Specify name of downloaded disk image

LsAgent_dmg="/tmp/LsAgent-osx.dmg"

# Download the latest LSAgent software disk image

/usr/bin/curl -L --output "$LsAgent_dmg" "$fileURL"

# Specify a /tmp/LsAgent mountpoint for the disk image
 
TMPMOUNT=`/usr/bin/mktemp -d /tmp/LsAgent`

# Mount the latest LsAgent disk image to /tmp/LsAgent mountpoint
 
hdiutil attach "$LsAgent_dmg" -mountpoint "$TMPMOUNT" -nobrowse -noverify -noautoopen
    

# Install LsAgent from the installer package stored inside the disk image

"/tmp/LsAgent/LsAgent-osx.app/Contents/MacOS/installbuilder.sh" --server "YourLansweeperServerFQDN" --port "9524" --agentkey "YourAgentKey" --prefix /usr/local/LsAgent --mode unattended
	
sleep 30
	
# Clean-up
 
# Unmount the LsAgent disk image from /tmp/LsAgent
 
/usr/bin/hdiutil detach "$TMPMOUNT"
 
# Remove the /tmp/LsAgent mountpoint
 
/bin/rm -rf "$TMPMOUNT"

# Remove the downloaded disk image

/bin/rm -rf "$LsAgent_dmg"
    
exit 0