#!/usr/bin/env bash

set -o pipefail

function list_sessions() {
  result="$(zmx list)"

  if [[ $result != "no sessions found"* ]]; then
    echo "$result"
  fi
}

function get_option() {
    {
        list_sessions | while IFS=$'\t' read -r session pid _; do
            session="${session#session_name=}"
            pid="${pid#pid=}"

            first_child=$(pgrep -P "$pid" | head -1)
            cmd="$(tr '\0' ' ' < "/proc/${first_child:-$pid}/cmdline" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
            
            echo -e "$session\0$session ($cmd)"
        done
        echo -e "\0"
        echo -e "[NEW]\0 [NEW]"
        echo -e "[QUIT]\0 [QUIT]"
    } \
    | fzf --no-multi --ansi --border --reverse \
        --height 40% --prompt 'zmx> ' \
        --header "Select a session to attach to." \
        --with-nth 2 --accept-nth 1 --delimiter '\0'
}

function attach() {
    zmx attach "$1" "$SHELL"
    printf '\ec'
}

function session_loop() {
    while true; do

        if ! session="$(get_option)"; then
            session="[QUIT]"
        fi

        case "$session" in
            "[NEW]" )
                read -rp "New session name: " name
                if [ -n "$name" ]; then
                    attach "$name"
                fi
            ;;
            "[QUIT]" )
                break
            ;;
            * )
                attach "$session"
            ;;
        esac
    done
}

if [ -n "$1" ]; then
    attach "$1"
fi

session_loop
