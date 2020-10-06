#!/bin/bash

# This script will check to see what the SSID is of the current WiFi network
# and will compare it to the list at "~/WallAware/UNSAFE_SSIDS.txt"
# if the SSID is found in the list then a random wallpaper is chosen
# from the CLEAN folder, if the SSID is not found then a random wallpaper
# will be chosen from the DIRTY folder.

# If either the CLEAN or DIRTY folders are left empty then when switching
# to that status the wallpaper will revert to the last wallpaper set
# using system Preferences. This can be useful if you want to set the DIRTY
# wallpapers but switch back to the default dynamic wallpaper that ships switch
# macOS for the CLEAN status...or vise versa I suppose.


SSID=$(networksetup -getairportnetwork en0 | sed -E 's,^Current Wi-Fi Network: (.+)$,\1,')
CLEAN=$(find -E -L ~/WallAware/Clean -type f -regex ".*\.(jpg|gif|png|jpeg)" \( -atime +1 -o -mtime -1 \) | ~/WallAware/gshuf -n 1)
DIRTY=$(find -E -L ~/WallAware/Dirty -type f -regex ".*\.(jpg|gif|png|jpeg)" \( -atime +1 -o -mtime -1 \) | ~/WallAware/gshuf -n 1)



if grep -Fxq "$SSID" ~/WallAware/UNSAFE_SSIDS.txt
then
    echo
    echo --------------------------------
    echo NETWORK=$SSID
    echo STATUS=NOT SAFE
    echo SET=$CLEAN
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$CLEAN\""
    touch [-acf] $CLEAN
    echo DONE
    echo --------------------------------
    echo
else
    if grep -q "You are not associated with an AirPort network" <<< "$SSID";
    then
        echo
        echo --------------------------------
        echo NETWORK=WIFI IS NOT CONNECTED OR IS DISABLED
        echo STATUS=PLAYING IT SAFE
        echo SET=$CLEAN
        osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$CLEAN\""
        touch [-acf] $CLEAN
        echo DONE
        echo --------------------------------
        echo
    else
        echo
        echo --------------------------------
        echo NETWORK=$SSID
        echo STATUS=THE COAST IS CLEAR
        echo SET=$DIRTY
        osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$DIRTY\""
        touch [-acf] "$DIRTY"
        echo DONE
        echo --------------------------------
        echo
    fi
fi

exit 0;
