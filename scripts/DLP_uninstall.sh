#!/bin/bash

LOG_DIR="/var/log/dlp"
mkdir -p "$LOG_DIR"

AGENT_DIR="/Library/Manufacturer/Endpoint Agent"
BIN="$AGENT_DIR/uninstall_agent1601"
LOG="$LOG_DIR/uninstall.log"
MARKER="$LOG_DIR/uninstall_complete"

echo "===== Symantec DLP Uninstall Start: $(date) =====" >> "$LOG"

# Validate binary file deployment didn't fail
if [ ! -f "$BIN" ]; then
    echo "ERROR: Uninstall binary missing at $BIN" >> "$LOG"
    echo "uninstall_failed" > "$MARKER"
    exit 1
fi

# Remove quarantine
xattr -dr com.apple.quarantine "$BIN" 2>>"$LOG"

chmod 755 "$BIN"


cd "$AGENT_DIR" || {
    echo "ERROR: Cannot cd to $AGENT_DIR" >> "$LOG"
    echo "uninstall_failed" > "$MARKER"
    exit 1
}

echo "Running uninstall tool..." >> "$LOG"


printf "Y\n" | "$BIN" >> "$LOG" 2>&1
EXIT_CODE=$?

echo "Exit code: $EXIT_CODE" >> "$LOG"

if [ "$EXIT_CODE" -eq 0 ]; then
    echo "uninstall_complete" > "$MARKER"
    chmod 644 "$MARKER"
    echo "SUCCESS" >> "$LOG"
else
    echo "uninstall_failed" > "$MARKER"
    chmod 644 "$MARKER"
    echo "FAILURE" >> "$LOG"
fi


if command -v jamf >/dev/null 2>&1; then
    echo "Running JAMF recon..." >> "$LOG"
    jamf recon >> "$LOG" 2>&1
    echo "JAMF recon complete." >> "$LOG"
else
    echo "jamf binary not found; skipping JAMF recon." >> "$LOG"
fi

exit 0
