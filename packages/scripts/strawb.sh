
function strawb() {
  quickshell -c ~/.dotfiles/shell "$@"
}

if [ "$#" -eq 0 ]; then
  strawb
  exit
elif [[ "$1" == "lock" || "$1" == "unlock" || "$1" == "lockImmediate" ]]; then
  strawb ipc --any-display call lockscreen "$1"
else
  strawb ipc --any-display "$@"
fi

