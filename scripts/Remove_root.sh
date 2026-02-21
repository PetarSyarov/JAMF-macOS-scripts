#!/bin/bash

ADMINS_TO_KEEP=("HelpDesk_account" "LocalAdminAccount")

if [[ "$EUID" -ne 0 ]]; then
  echo "Please run this script as root (sudo)."
  exit 1
fi

# Verify that all required admin accounts exist
for ADMIN in "${ADMINS_TO_KEEP[@]}"; do
  if ! id "$ADMIN" &>/dev/null; then
    echo "User '$ADMIN' does not exist. Exiting."
    exit 1
  fi
done

echo "Keeping admin rights for: ${ADMINS_TO_KEEP[*]}"
echo "Removing admin rights from all other users..."

ADMIN_USERS=$(dscl . -read /Groups/admin GroupMembership | cut -d " " -f 2-)

for USER in $ADMIN_USERS; do
  KEEP=false
  for ADMIN in "${ADMINS_TO_KEEP[@]}"; do
    if [[ "$USER" == "$ADMIN" ]]; then
      KEEP=true
      break
    fi
  done

  if [[ "$KEEP" == false ]]; then
    echo "Removing $USER from admin group..."
    dseditgroup -o edit -d "$USER" -t user admin
  else
    echo "Skipping $USER (will remain admin)"
  fi
done

echo "All other admin rights removed. Only '${ADMINS_TO_KEEP[*]}' have admin access now."
