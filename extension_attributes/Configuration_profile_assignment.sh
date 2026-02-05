#!/bin/bash

PROFILE_NAME="Configuration_profile_name"

if /usr/bin/profiles show -output stdout 2>/dev/null | grep -q "$PROFILE_NAME"; then
    echo "<result>YES</result>"
else
    echo "<result>NO</result>"
fi