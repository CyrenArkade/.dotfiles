#!/usr/bin/env bash
# maybe I'll do something with this script at some point

entries=" Logout\n Suspend\n Reboot\n Shutdown"

selected=$(echo -e "$entries" | wofi --width 1 --height 110 --xoffset -190 --yoffset -23 --dmenu --cache-file /dev/null --style ~/.config/wofi/no-input.css --location bottom_right | awk '{print tolower($2)}')

case $selected in
  logout)
    pkill -u kia;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff;;
esac