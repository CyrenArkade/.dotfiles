function preview() {
    row="$1"
    if echo "$row" | grep -vqP '^\d+\t\[\[ binary data .* \]\]'; then
        echo "$row" | cliphist decode
    else
        echo "$row" | cliphist decode | kitten icat --transfer-mode=memory --unicode-placeholder --place "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0"
    fi
}
export -f preview

id="$(cliphist list | \
    fzf --reverse --header-first \
        --separator ' ' --no-info --padding 1,2 \
        --prompt "  >" --header "Clipboard History" \
        --with-nth 2.. --preview "preview {}" \
        --with-shell 'bash -c' \
)"
test -z "$id" && exit

echo "$id" | cliphist decode | wl-copy