#!/bin/bash
PIDFILE="/tmp/autoclick.pid"

if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
    exit 0
fi

while true; do
   ydotool click 0xC0        # left click
  # ydotool key 18:1 18:0       # E key
    sleep 0.001
done &

echo $! > "$PIDFILE"
