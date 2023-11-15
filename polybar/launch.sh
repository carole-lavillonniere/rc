#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bars

echo "---" | tee -a /tmp/polybar1.log
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
  done
else
  polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
fi

echo "Bars launched..."
