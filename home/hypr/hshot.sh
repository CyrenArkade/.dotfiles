#!/usr/bin/env bash

folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"

hyprshot -z -m region -o "$folderName" -f "$fileName"