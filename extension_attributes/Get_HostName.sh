#!/bin/bash


hostName=$(scutil --get HostName 2>/dev/null)

if [ -z "$hostName" ]; then
    hostName="(No HostName Set)"
fi

echo "<result>$hostName</result>"
