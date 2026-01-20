#!/bin/sh

list=$(echo $(xinput --list | grep "Logitech G502 LIGHTSPEED Wireless Gaming Mouse"))
info=${list%% \[slave pointer*}
[[ "$info" == *"keyboard"* ]] && info=${info##*\[slave keyboard}
id=${info##*=}

xrdb -merge ~/.Xresources &
xset s off -dpms &
xidlehook --not-when-audio --timer 570 'rofi-lockscreen' '' &
xgifwallpaper -v -s FILL ~/Pictures/OTHERWORLD_View.gif &
xinput set-prop $id "libinput Scroll Method Enabled" 0, 0, 1 &
unclutter &
dunst &
picom &
wal -R &
greenclip daemon &
(sleep 5 && $TERMINAL -e rmpc) &
(sleep 5 && $TERMINAL -e steam) &
(sleep 5 && librewolf) &
(sleep 5 && thunderbirdSucks) &
(sleep 5 && Telegram) &
(sleep 5 && signal-desktop --password-store=kwallet6) &
dwmblocks &
exec dwm
