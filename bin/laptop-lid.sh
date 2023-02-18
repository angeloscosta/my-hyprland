#!/bin/bash

grep -q closed /proc/acpi/button/lid/*/state
if [[ $? = 0 ]]; then
  
  status=$(cat /sys/class/drm/card0-HDMI-A-1/status)
  
  if [[ $status = disconnected ]]; then
    dunstify "disconnected"
    systemctl suspend-then-hibernate
    swaylock -i `find ~/Pictures/Wallpaper/Lockscreen/ -type -f | shuf -n 1`
    sleep 0.1
  elif [[ $status = connected ]]; then
    dunstify "connected"
    hyprctl dispatch dpms off eDP-1
    #hyprctl dispatch swapactiveworkspaces eDP-1 HDM1-A-1
  fi

elif [[ $? = 1 ]]; then
  hyprctl dispatch dpms on eDP-1
fi

