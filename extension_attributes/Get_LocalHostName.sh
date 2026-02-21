#!/bin/bash


localhostName=$(scutil --get LocalHostName 2>/dev/null)

if [ -z "$localhostName" ]; then
    localhostName="(No LocalHostName Set)"
fi

echo "<result>$localhostName</result>"
