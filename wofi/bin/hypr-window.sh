#!/usr/bin/env bash

DIR="$HOME/.config"
theme="--style $DIR/wofi/style.css"
command="wofi $theme -d -L 6 -W 450"
#dunstify "$command"

state="$(hyprctl -j clients)"
options="$(hyprctl -j clients | jq -r '.[] | "\(.workspace.name) \(.class)"')"

#chosen="$(echo -e "$options" | wofi -p "Run as $USER" -d -b -H 300 -W 450)"
chosen="$(echo -e "$options" | $command -p "Search")"
dunstify "$chosen"

#workspace="$(echo "$chosen" | awk -F ' ' '{print $1}')"
window="$(echo $chosen | awk -F ' ' '{print $2}')"

#hyprctl dispatch workspace "$workspace"
hyprctl dispatch focuswindow "$window"
