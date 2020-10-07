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


###OPTIONS###
#Path to the A folder
ADir=$(echo ~/WallAware/A)
#Path to the B folder
BDir=$(echo ~/WallAware/B)
#How long to wait before seeing the same wallpaper again? (In days)
Age=$(echo 14)




###DO NOT EDIT BELOW THIS LINE###

#Gets the currnt SSID
SSID=$(networksetup -getairportnetwork en0 | sed -E 's,^Current Wi-Fi Network: (.+)$,\1,')

#Check SSID against predefined List
if grep -Fxq "$SSID" ~/WallAware/SSIDS.txt

then
  my_find() {
      find -E -L "$ADir" -type f '(' -false $(for ext in png jpg gif jpeg; do echo "-o -name *.$ext"; done) ')' "$@"
  }

  if my_find -print0  | xargs -0 stat -f "%N %B %m" |
  ~/WallAware/gawk '$NF==$(NF-1) {NF=NF-2; print}' | head -1 | grep .;

  then
      B=$(my_find -print0  | xargs -0 stat -f "%N %B %m" |
      ~/Wallaware/gawk '$NF==$(NF-1) {NF=NF-2; print}' | head -1)

  elif find -L -E "$ADir" -type f -mtime +"$Age" -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1 | grep .;

  then
      B=$(find -L -E "$ADir" -type f -mtime +"$Age" -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1)

  else
      B=$(find -L -E "$ADir" -type f -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1)
  fi
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
      my_find() {
          find -E -L "$ADir" -type f '(' -false $(for ext in png jpg gif jpeg; do echo "-o -name *.$ext"; done) ')' "$@"
      }

      if my_find -print0  | xargs -0 stat -f "%N %B %m" |
      ~/WallAware/gawk '$NF==$(NF-1) {NF=NF-2; print}' | head -1 | grep .;

      then
          B=$(my_find -print0  | xargs -0 stat -f "%N %B %m" |
          ~/Wallaware/gawk '$NF==$(NF-1) {NF=NF-2; print}' | head -1)

      elif find -L -E "$ADir" -type f -mtime +"$Age" -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1 | grep .;

      then
          B=$(find -L -E "$ADir" -type f -mtime +"$Age" -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1)

      else
          B=$(find -L -E "$ADir" -type f -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1)
      fi
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
      my_find() {
          find -E -L "$BDir" -type f '(' -false $(for ext in png jpg gif jpeg; do echo "-o -name *.$ext"; done) ')' "$@"
      }

      if my_find -print0  | xargs -0 stat -f "%N %B %m" |
      ~/WallAware/gawk '$NF==$(NF-1) {NF=NF-2; print}' | head -1 | grep .;

      then
          B=$(my_find -print0  | xargs -0 stat -f "%N %B %m" |
          ~/Wallaware/gawk '$NF==$(NF-1) {NF=NF-2; print}' | head -1)

      elif find -L -E "$BDir" -type f -mtime +"$Age" -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1 | grep .;

      then
          B=$(find -L -E "$BDir" -type f -mtime +"$Age" -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1)

      else
          B=$(find -L -E "$BDir" -type f -regex ".*\.(jpg|gif|png|jpeg)" | ~/WallAware/gshuf -n 1)
      fi
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
