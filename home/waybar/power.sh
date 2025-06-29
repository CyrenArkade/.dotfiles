#!/usr/bin/env bash

entries=" Suspend\n Logout\n Reboot\n Shutdown"

selected=$(echo -e "$entries" | wofi --width 1 --height 110 --xoffset -190 --yoffset -23 --dmenu --cache-file /dev/null --style ~/.config/wofi/no-input.css --location bottom_right | awk '{print tolower($1)}')

case $selected in
  suspend)
    systemctl suspend;;
  logout)
    loginctl terminate-session $(cat /proc/self/sessionid);;
  reboot)
    systemctl reboot;;
  shutdown)
    systemctl poweroff;;
esac