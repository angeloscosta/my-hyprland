#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

DIR="$HOME/.config/"
theme="--style $DIR/wofi/style.css"

time=`date +%Y-%m-%d-%H-%M-%S`
#geometry=`xrandr | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="`xdg-user-dir PICTURES`/Screenshots"
#dir="$HOME/Pictures/Screenshots"
file="Screenshot_${time}.png"

# Buttons
screen=" Screen"
area=" Area"
window=" Window"
infive=" In 5 seconds"
inten=" Insert delay"

# notify and view screenshot
notify_view () {
	#dunstify -u low --replace=699 "Copied to clipboard."
	#viewnior ${dir}/"$file"
	if [[ -e "$dir/$file" ]]; then
		dunstify -u low --replace=699 "Screenshot Saved."
	else
		dunstify -u low --replace=699 "Screenshot Deleted."
	fi
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	#cd ${dir} && sleep 0.5 && maim -u -f png | tee "$file" | xclip -selection clipboard -t image/png
	cd ${dir} && sleep 0.1 && grim $file
  notify_view
}

shot5 () {
	countdown '5'
	#sleep 1 && cd ${dir} && maim -u -f png | tee "$file" | xclip -selection clipboard -t image/png
	cd ${dir} && sleep 0.1 && grim $file
  notify_view
}

shot10 () {
	countdown '10'
	#sleep 1 && cd ${dir} && maim -u -f png | tee "$file" | xclip -selection clipboard -t image/png
	cd ${dir} && sleep 0.1 && grim $file
  notify_view
}

shotwin () {
	location=$(hyprctl -j activewindow | jq -r '. | "\(.at)"' | tr -d '[]')
	size=$(hyprctl -j activewindow | jq -r '. | "\(.size)"' | tr -d '[]' | tr , x)
	#dunstify --replace=699 "$location $size"
	
	#cd ${dir} && maim -u -f png -i `hyprctl -j activewindow` | tee "$file" | grim $file
	#cd ${dir} && grim -g "$(hyprctl -j activewindow | gojq -r '. | "\(.x),\(.y) \(.width)x\(.height)"')"
	cd ${dir} && sleep 0.1 && grim -g "$location $size" $file
	notify_view
}

shotarea () {
	#cd ${dir} && maim -u -f png -s -b 2 -c 0.35,0.55,0.85,0.25 -l | tee "$file" | xclip -selection clipboard -t image/png
	cd ${dir} && grim -g "$(slurp)" $file
  notify_view
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# Variable passed to rofi
options="$screen\n$area\n$window\n$infive\n$inten"

chosen="$(echo -e "$options" | wofi -d -H 292 -W 450 --define hide_search=true)"

case $chosen in
    $screen)
		  shotnow;;
    $area)
		  shotarea;;
    $window)
		  shotwin;;
    $infive)
		  shot5;;
    $inten)
		  shot10;;
esac

