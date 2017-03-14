#!/bin/bash
#
#	Script to increase brightness for macro buttons
#

# Get current brightness of the display
brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

if (($brightness > 0)); then
let "brightness-=10"
echo "echo $brightness > /sys/class/backlight/intel_backlight/brightness" | sudo zsh 
fi
