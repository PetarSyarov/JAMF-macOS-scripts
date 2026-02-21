#!/bin/zsh

# disk image
(arch -arm64 true && ! arch -x86_64 true) &> /dev/null && softwareupdate --install-rosetta --agree-to-license 2> /dev/null | grep -v this

fileURL="https://content.lansweeper.com/lsagent-mac/"

LsAgent_dmg="/tmp/LsAgent-osx.dmg"

/usr/bin/curl -L --output "$LsAgent_dmg" "$fileURL"
 
TMPMOUNT=`/usr/bin/mktemp -d /tmp/LsAgent`

hdiutil attach "$LsAgent_dmg" -mountpoint "$TMPMOUNT" -nobrowse -noverify -noautoopen
    
"/tmp/LsAgent/LsAgent-osx.app/Contents/MacOS/installbuilder.sh" --server "YourLansweeperServerFQDN" --port "9524" --agentkey "YourAgentKey" --prefix /usr/local/LsAgent --mode unattended
	
sleep 30
	
# Clean-up
 
/usr/bin/hdiutil detach "$TMPMOUNT"
  
/bin/rm -rf "$TMPMOUNT"

/bin/rm -rf "$LsAgent_dmg"
    
exit 0