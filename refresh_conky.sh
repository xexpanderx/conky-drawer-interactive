#!/bin/sh
colors=`cat $HOME/.cache/wal/colors.Xresources | grep "*color" | tr -d "*:" | sed 's/ //g' | sed 's/#/="#/g' | sed ':a;N;$!ba;s/\n/"\n/g'`
colors="${colors}\""
cat ~/.conky/conky-drawer-interactive/templates/drawer_template.lua | awk -v srch="COLORFIELD" -v repl="$colors" '{ sub(srch,repl,$0); print $0 }' > ~/.conky/conky-drawer-interactive/lua/drawer.lua
