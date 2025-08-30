#!/usr/bin/env bash

entries="Suspend\nLogout\nReboot\nShutdown"

selected=$(echo -e "$entries" | rofi -dmenu -no-show-icons -theme-str 'window {width: 5em; height: 5em; location: south east; x-offset: -50px; y-offset: -45px;} mainbox {children: [listview];} listview {border: none;}' | awk '{print tolower($1)}')

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