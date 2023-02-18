#!/usr/bin/env bash

change_wallpaper() {
  image=$(find ~/Pictures/Wallpaper/shvedes -type f | shuf -n 1)
  #wallpaper=$(find ~/Pictures/Wallpaper/Nighttime -type f | shuf --random-source=/dev/urandom -n 1)
  echo -ne "preload = $image\nwallpaper = ,$image\n" > ~/.config/hypr/hyprpaper.conf
  if [[ `pidof hyprpaper` ]]; then
	  hyprctl hyprpaper unload all
	  hyprctl hyprpaper preload $image
	  hyprctl hyprpaper wallpaper eDP-1,$image
	  hyprctl hyprpaper wallpaper HDMI-A-1,$image
  else
	  tmux new -d hyprpaper &> /dev/null
  fi
}

change_wallpaper
sleep 600
~/.config/hypr/bin/wallpaper.sh

