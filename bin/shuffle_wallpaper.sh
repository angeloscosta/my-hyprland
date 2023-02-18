#!/usr/bin/env bash

wallpaper=$(find ~/Pictures/Wallpaper/shvedes -type f | shuf -n 1)
#wallpaper=$(find ~/Pictures/Wallpaper/Nighttime -type f | shuf --random-source=/dev/urandom -n 1)
echo -ne "preload = $wallpaper\nwallpaper = ,$wallpaper\n" > ~/.config/hypr/hyprpaper.conf
if [[ `pidof hyprpaper` ]]; then
	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload $wallpaper
	hyprctl hyprpaper wallpaper eDP-1,$wallpaper
	hyprctl hyprpaper wallpaper HDMI-A-1,$wallpaper
else
	tmux new -d hyprpaper &> /dev/null
fi
