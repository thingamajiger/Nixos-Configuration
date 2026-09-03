#!/bin/bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

hide_dock() {
    pkill -RTMIN+3 nwg-dock-hyprland
}

show_dock() {
    pkill -RTMIN+2 nwg-dock-hyprland
}

socat -u UNIX-CONNECT:"$SOCKET" - | while read -r line; do
    case "$line" in
        fullscreen>>1)
            hide_dock
            ;;
        fullscreen>>0)
            show_dock
            ;;
    esac
done
