#!/bin/sh

# Get current brightness level on macOS using osascript
# This method works on macOS by querying the brightness through AppleScript
BRIGHTNESS=$(osascript -e 'tell application "System Events" to tell application process "ControlCenter"' -e 'try' -e 'set value to value of slider 1 of group 1 of group 2 of window 1' -e 'return (value * 100) as integer' -e 'on error' -e 'return 50' -e 'end try' -e 'end tell' 2>/dev/null)

# Fallback: try alternative method
if [ -z "$BRIGHTNESS" ] || [ "$BRIGHTNESS" = "" ]; then
  # Use brightness command if available (requires installation)
  if command -v brightness &> /dev/null; then
    BRIGHTNESS=$(brightness -l | awk '{printf "%.0f", $2 * 100}')
  else
    # Default fallback value
    BRIGHTNESS=50
  fi
fi

sketchybar --set $NAME label="${BRIGHTNESS}%"

