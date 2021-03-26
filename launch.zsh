#!/usr/bin/env zsh
 
# Terminate already running bar instances
killall -q polybar
 
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Find out the wireless network interface
export WINAME=`cat /proc/net/wireless | tail -n 1 | cut -d: -f1`

# Find out the wired network interface
export LANNAME=`ip addr | grep "BROADCAST" | grep ': en' | cut -d: -f2 | tr -d '[:space:]'`
 
# Launch bar
polybar main &
 
echo "Bar launched"
