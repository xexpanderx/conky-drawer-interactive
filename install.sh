#!/bin/bash
mkdir -p ~/.conky/conky-drawer-interactive/
cp -r templates ~/.conky/conky-drawer-interactive/
cp -r lua ~/.conky/conky-drawer-interactive/
cp -r configs ~/.conky/conky-drawer-interactive/
cp start_conky.sh ~/.conky/conky-drawer-interactive/
cp refresh_conky.sh ~/.conky/conky-drawer-interactive/
chmod +x ~/.conky/conky-drawer-interactive/start_conky.sh
chmod +x ~/.conky/conky-drawer-interactive/refresh_conkys.sh
~/.conky/conky-drawer-interactive/start_conky.sh&
