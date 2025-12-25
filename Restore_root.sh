#!/bin/bash

# Script to restore admin rights to all local users (non-system accounts)

# Get list of local users (excluding system accounts)
users=$(dscl . list /Users | grep -v '^_' | grep -v daemon | grep -v nobody | grep -v root)

for user in $users; do
    if id -Gn "$user" | grep -qw "admin"; then
        echo "$user is already an admin"
    else
        echo "Adding $user to admin group..."
        /usr/sbin/dseditgroup -o edit -a "$user" -t user admin
    fi
done

exit 0
