#!/bin/bash

bars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

cleanup() {
    exit 0
}

trap cleanup SIGPIPE SIGTERM SIGINT

cava -p /dev/stdin <<'EOF' | while read -r line; do
[general]
bars = 8
framerate = 60

[input]
method = pipewire

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
channels = mono
EOF
    out=""
    IFS=';' read -ra vals <<< "$line"
    for v in "${vals[@]}"; do
        if [[ "$v" =~ ^[0-7]$ ]]; then
            out+="${bars[$v]} "
        else
            out+="  "
        fi
    done
    printf '%s\n' "$out" || exit 0
done
