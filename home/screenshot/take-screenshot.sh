folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
export fullPath="$folderName/$fileName"

mkdir -p "$folderName"

function whileStill() {
    set -e

    grim -g "$(slurp -d -b 00000060 -c b4befeff)" "$fullPath"
}
export -f whileStill

still -p -c whileStill

if [ ! -f "$fullPath" ]; then
    exit
fi

wl-copy < "$fullPath"

action=$(notify-send "Saved and copied $fileName" -i "$fullPath" -u low -t 5000 \
    --action view=View --action "satty=Edit (Satty)" --action "gimp=Edit (GIMP)" --action "copyPath=Copy Path")
case "$action" in
    "view" )
        xdg-open "$fullPath"
    ;;
    "satty" )
        satty -f "$fullPath" -o "$fullPath"
    ;;
    "gimp" )
        gimp "$fullPath"
    ;;
    "copyPath" )
        echo -n "$fullPath" | wl-copy
    ;;
esac