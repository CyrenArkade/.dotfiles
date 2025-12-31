folderName="$HOME/Pictures/Screenshots/$(date +%Y)-$(date +%m)"
fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
fullPath="$folderName/$fileName"

mkdir -p "$folderName"

function whileStill() {
    set -e

    read -r x y w h < <(slurp -f $'%x %y %w %h\n' -d -b 00000060 -c b4befeff)
    sx=$(((x+2)/4*4))
    sy=$(((y+2)/4*4))
    w=$((w+x-sx))
    h=$((h+y-sy))

    echo "${sx},${sy} ${w}x${h}"
}
export -f whileStill

crop="$(still -p -c whileStill)"

if [ -z "$crop" ]; then
    exit
fi

grim -g "$crop" "$fullPath"
wl-copy < "$fullPath"

action=$(notify-send "Saved and copied $fileName" -i "$fullPath" -u low -t 5000 --action open=Open --action edit=Edit --action "copyPath=Copy Path")
case "$action" in
    "open" )
        xdg-open "$folderName"
    ;;
    "edit" )
        satty -f "$fullPath" -o "$fullPath"
    ;;
    "copyPath" )
        echo -n "$fullPath" | wl-copy
    ;;
esac