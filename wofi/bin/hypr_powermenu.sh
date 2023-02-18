#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

DIR="$HOME/.config"
images="$HOME/Pictures/Wallpaper/Lockscreen/"
theme="--style $DIR/wofi/lateral.css"
command="wofi $theme -d -L 7 -W 80 --define halign=center --define hide_search=true --define location=right -x -10"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
hybernate=""
suspend=""
lock=""
logout=""

options="$shutdown\n$reboot\n$hybernate\n$suspend\n$lock\n$logout"

# Variable passed to rofi
chosen="$(echo -e "$options" | $command -p "UP - $uptime")"
#chosen="$(echo -e "$options" | wofi $theme -d -b -L 5 -W 80 --define halign=center --define hide_search=true --define location=right -x -10)"
case $chosen in
    $shutdown)
      mpc -q stop
      systemctl poweroff
    ;;
    $reboot)
      mpc -q stop
      systemctl reboot
    ;;
    $hybernate)
      mpc -q stop
      systemctl hybernate
      #swaylock -i ~/Pictures/Wallpaper/Lockscreen/mountain.jpg
      swaylock -i `find $images -type f | shuf -n 1`
    ;;
    $suspend)
      mpc -q stop
      #amixer set Master mute
      systemctl hybrid-sleep
      #swaylock -i ~/Pictures/Wallpaper/Lockscreen/mountain.jpg
      swaylock -i `find $images -type f | shuf -n 1`
    ;;
    $lock)
      swaylock -i `find $images -type f | shuf -n 1`
    ;;
    $logout)
      mpc -q stop
      hyprctl dispatch exit
    ;;
esac
exit
