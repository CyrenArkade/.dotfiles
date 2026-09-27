folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
export fullPath="$folderName/$fileName"

mkdir -p "$folderName"

capturePath="$(grabit -e -o)"

if [ ! -f "$capturePath" ]; then
  exit
fi

mv "$capturePath" "$fullPath"
wl-copy < "$fullPath"

action=$(notify-send "Saved and copied $fileName" -i "$fullPath" -u low -t 5000 \
  --action view=View --action "gimp=Edit (GIMP)" --action "copyPath=Copy Path")
case "$action" in
  "view" )
    xdg-open "$fullPath"
  ;;
  "gimp" )
    gimp "$fullPath"
  ;;
  "copyPath" )
    echo -n "$fullPath" | wl-copy
  ;;
esac
