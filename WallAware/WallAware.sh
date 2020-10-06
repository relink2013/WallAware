#!/bin/bash

# This script will check to see what the SSID is of the current WiFi network
# and will compare it to the list at "~/WallAware/SSIDS.txt"
# if the SSID is found in the list then a random wallpaper is chosen
# from the A folder, if the SSID is not found then a random wallpaper
# will be chosen from the B folder.

# If either the A or B folders are left empty then when switching
# to that status the wallpaper will revert to the last wallpaper set
# using system Preferences. This can be useful if you want to set the B
# wallpapers but switch back to the default dynamic wallpaper that ships switch
# macOS for the A status...or vise versa I suppose.


SSID=$(networksetup -getairportnetwork en0 | sed -E 's,^Current Wi-Fi Network: (.+)$,\1,')
A=$(find -E -L ~/WallAware/A -type f -regex ".*\.(jpg|gif|png|jpeg)" \( -atime +5 -o -mtime -1 \) | ~/WallAware/gshuf -n 1)
B=$(find -E -L ~/WallAware/B -type f -regex ".*\.(jpg|gif|png|jpeg)" \( -atime +5 -o -mtime -1 \) | ~/WallAware/gshuf -n 1)



if grep -Fxq "$SSID" ~/WallAware/SSIDS.txt
then
    echo
    echo --------------------------------
    echo NETWORK=$SSID
    echo STATUS=SSID FOUND. PICKING FROM FOLDER A
    echo SET=$A
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$A\""
    touch [-acf] $A
    echo DONE
    echo --------------------------------
    echo
else
    if grep -q "You are not associated with an AirPort network" <<< "$SSID";
    then
        echo
        echo --------------------------------
        echo NETWORK=WIFI IS NOT CONNECTED OR IS DISABLED
        echo STATUS=UNKNOWN STATUS. PICKING FROM FOLDER A
        echo SET=$A
        osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$A\""
        touch [-acf] $A
        echo DONE
        echo --------------------------------
        echo
    else
        echo
        echo --------------------------------
        echo NETWORK=$SSID
        echo STATUS=SSID NOT LISTED. PICKING FROM FOLDER B
        echo SET=$B
        osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$B\""
        touch [-acf] "$B"
        echo DONE
        echo --------------------------------
        echo
    fi
fi

exit 0;
