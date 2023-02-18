#!/usr/bin/env bash

#grep -q closed /proc/acpi/button/lid/*/state
status=$(cat /sys/class/drm/card0-HDMI-A-1/status)
if [ $status = connected ]
then
    #echo "HDMI connected"
    #hyprtcl dispatch eDP-1 disable

    #hyprctl dispatch swapactiveworkspaces eDP-1 HDM1-A-1
    hyprtcl dispatch dpms off eDP-1

elif [ $status = disconnected ]
then
    #echo "HDMI disconnected"
    #hyprctl dispatch eDP-1 preferred auto 1
    hyprctl dispatch dpms on eDP-1
fi
