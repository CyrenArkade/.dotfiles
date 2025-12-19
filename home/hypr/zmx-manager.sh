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
            
            echo -e "$session\0   $session ($cmd)"
        done
        echo -e "\0"
        echo -e "[NEW]\0 󰐕 [NEW]"
        if [ -v last_session ]; then
            echo -e "[KILL]\0  [KILL $last_session]"
        fi
        echo -e "[QUIT]\0  [QUIT]"
    } \
    | fzf --no-multi --ansi --reverse --header-first \
        --header 'Select a session to attach to.' \
        --prompt '  zmx> ' --height 40% \
        --separator ' ' --no-info --padding 1,2 \
        --with-nth 2 --accept-nth 1 --delimiter '\0'
}

function attach() {
    zmx attach "$1" "$SHELL"
    printf '\ec'
    last_session="$1"
}

function session_loop() {
    while true; do

        session="$(get_option)"

        if [ -z "$session" ]; then
            continue
        fi

        case "$session" in
            "[NEW]" )
                read -rp $'\n New session name: ' name </dev/tty
                if [ -n "$name" ]; then
                    attach "$name"
                fi
            ;;
            "[KILL]" )
                zmx kill "$last_session" 1> /dev/null
                unset last_session
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
