#!/usr/bin/env bash

DIR="$HOME/.config/"
theme="--style $DIR/wofi/themes/open.rasi"

# Apps
app1="Shuffle Wallpaper"
app2="Lapce"
app3="Discord"
app4="Steam (BigPicture)"
app5="Youtube Music"

# Options
options="$app1\n$app2\n$app3\n$app4\n$app5"

# Variable passed to wofi
chosen="$(echo -e "$options" | wofi -p "Run as $USER" -d -b -H 292 -W 450)"

case $chosen in
  $app1)
    shuffle_wallpaper;;
  $app2)
    lapce;;
  $app3)
    discord;;
  $app4)
    steam-native -gamepadui;;
  $app5)
    youtube-music;;
esac

