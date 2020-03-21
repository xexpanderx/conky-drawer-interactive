#!/bin/sh
~/.conky/conky-drawer-interactive/refresh_conky.sh
conky -c ~/.conky/conky-drawer-interactive/configs/drawer.conf&
while inotifywait -qqe modify $HOME/.cache/wal/colors.Xresources; do ~/.conky/conky-drawer-interactive/refresh_conky.sh ; done
