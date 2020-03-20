#!/bin/sh
~/.conky/onky-drawer-interactive/refresh_conky.sh
conky -c ~/.conky/conky-drawer-interactive/configs/drawer.conf&
while inotifywait -qqe modify $HOME/.cache/wal/colors.Xresources; do ~/.conky/onky-drawer-interactive/refresh_conky.sh ; done
