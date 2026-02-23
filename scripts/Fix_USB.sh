# Run first to identify correct disk number

diskutil list

# Force unmount

diskutil unmountDisk force /dev/diskX

# Wipe the partition table and format drive

sudo diskutil eraseDisk ExFAT USB GPT /dev/diskX
