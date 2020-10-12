#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include pashua.sh to be able to use the 2 functions defined in that file
source "$MYDIR/pashua.sh"

#Adircfg=$(sed -n 1p ~/WallAware/config | sed 's/.*=//')

# Define what the dialog should be like
# Take a look at Pashua's Readme file for more info on the syntax

ADir=$(sed -n 1p ~/WallAware/config | sed 's/^.*=//')
BDir=$(sed -n 2p ~/WallAware/config | sed 's/^.*=//')
Age=$(sed -n 3p ~/WallAware/config | sed 's/^.*=//')
Chenable=$(sed -n 4p ~/WallAware/config | sed 's/^.*=//')
chtime=$(sed -n 5p ~/WallAware/config | sed 's/^.*=//')
ssidm=$(sed -n 6p ~/WallAware/config | sed 's/^.*=//')
netm=$(sed -n 7p ~/WallAware/config | sed 's/^.*=//')
btm=$(sed -n 8p ~/WallAware/config | sed 's/^.*=//')

conf="
# Set window title
*.title = WallAware Setup



# Introductory text
txt.type = text
txt.default = WallAware is an opensource script for macOS to change wallpapers based on the currently connected WiFi network. WallAware is made almost entirely of Shell script, and GNU tools. [return][return]-The main logic of WallAware uses shell script, and GNU tools, along with some basic Apple script. Written by Me with the help of a lot of Googling. [return]-The menu bar application was created using BitBar (Copyright (c) 2014-2016 Mat Ryer) [return]-The settings application was created using Pashua (Copyright (c) 2013-2018 Carsten Blum)
txt.height = 276
txt.width = 310
txt.x = 340
txt.y = 44
txt.tooltip = Good stuff to know”
-
#Warning Text
warn.type=text
warn.default=_________________ !!!WARNING!!! _________________[return]DO NOT CLOSE THIS WINDOW WITHOUT PRESSING \"OK\" OR ALL VALUES WILL BE SET TO ZERO AND WALLAWARE WILL NOT FUNCTION CORRECTLY.
-
# Set A Directory
ADir.type = openbrowser
ADir.rely=-15
ADir.mandatory = yes
ADir.label = Set Directory for "A"
ADir.default = ${ADir}
ADir.width=310
ADir.tooltip = Set the directory that WallAware should look to for Directory "A"

# Set B Directory
BDir.type = openbrowser
BDir.mandatory = yes
BDir.label = Set Directory for "B"
BDir.default = ${BDir}
BDir.width=310
BDir.tooltip = Set the directory that WallAware should look to for Directory "B"


# Set repeat age
Age.type = popup
Age.mandatory = yes
Age.label = Set the repeat age for Wallpapers
Age.width = 310
Age.option = 1 Day
Age.option = 2 Days
Age.option = 3 Days
Age.option = 4 Days
Age.option = 5 Days
Age.option = 6 Days
Age.option = 7 Days
Age.option = 14 Days
Age.option = 30 Days
Age.option = 90 Days
Age.option = 180 Days
Age.option = 365 Days
Age.default = ${Age}
Age.tooltip = How old (in days) should a wallpaper be before it is shown again?


# Enable Switcher
cha.type = checkbox
cha.label = Automatically change wallpaper every:
cha.tooltip = Check to enable WallAware timer launch daemon.
cha.default = ${Chenable}
cha.rely=-19

# Set switcher time
cht.type = popup
cht.mandatory = no
cht.width = 310
cht.option = 1 Minute                                                       [60]
cht.option = 5 Minutes                                                  [300]
cht.option = 10 Minutes                                                [600]
cht.option = 15 Minutes                                                [900]
cht.option = 30 Minutes                                              [1800]
cht.option = 45 Minutes                                              [2700]
cht.option = 1 Hour                                                      [3600]
cht.option = 2 Hours                                                    [7200]
cht.option = 6 Hours                                                  [21600]
cht.option = 12 Hours                                                [43200]
cht.option = 24 Hours                                               [86400]
cht.default= ${chtime}
cht.tooltip = How often do you want your wallpaper to be changed?

#Enable/Disable Launch Agents

# SSID monitor
ssidm.type = checkbox
ssidm.disabled = yes
ssidm.label = Watch for SSID changes
ssidm.tooltip = Check to enable the WallAware SSID monitoring launch daemon. WallAware wont do much without this, its kind of the heart and soul of the entire project.
ssidm.default = ${ssidm}
ssidm.rely=-19

# Network monitor
netm.type = checkbox
netm.label = Watch for WiFi turned ON/OFF
netm.tooltip = Check to enable the WallAware Network monitoring launch daemon. This will monitor the status of all network settings, so it may cause WallAware to trigger on non-WiFi related network changes too, such as connecting to Ethernet or a VPN. However without this it is possible that if the WiFi is turned ON or OFF WallAware will be unaware of the change and not trigger when it should.
netm.default = ${netm}
netm.rely=-19

# Bluetooth monitor
btm.type = checkbox
btm.label = Watch for Connections to Personal Hotspot
btm.tooltip = Check to enable the WallAware Bluetooth monitoring launch daemon. This daemon monitors the status of your Bluetooth since this is changed when connecting to an iOS Personal Hotspot. If you do not actively use an iOS device as a personal hotspot then you would be better off leaving this unchecked as it will cause your wallpaper to change every time a bluetooth device is connected/disconnected or bluetooth is turned on/off.
btm.default = ${btm}
btm.rely=-19


# Add a cancel button with default label
#cb.type = cancelbutton
#cb.tooltip = This is an element of type “cancelbutton”

db.type = defaultbutton
db.tooltip = This is an element of type “defaultbutton” (which is automatically added to each window, if not included in the configuration)
"

if [ -d '/Volumes/Pashua/Pashua.app' ]
then
	# Looks like the Pashua disk image is mounted. Run from there.
	customLocation='/Volumes/Pashua'
else
	# Search for Pashua in the standard locations
	customLocation=''
fi

# Get the icon from the application bundle
locate_pashua "$customLocation"
bundlecontents=$(dirname $(dirname "$pashuapath"))
if [ -e "$bundlecontents/Resources/AppIcon@2.png" ]
then
    conf="$conf
          img.type = image
					img.x = 435
          img.y = 248
          img.maxwidth = 128
          img.tooltip = Look a nifty new Icon!
          img.path = $bundlecontents/Resources/AppIcon@2.png"
fi

pashua_run "$conf" "$customLocation"
rm ~/WallAware/config


echo "Pashua created the following variables:"
echo "Adir=$ADir" >> ~/WallAware/config
echo "Bdir=$BDir" >> ~/WallAware/config
echo "Age=$Age" >> ~/WallAware/config
echo "cha=$cha" >> ~/WallAware/config
echo "cht=$cht" >> ~/WallAware/config
echo "ssidm=$ssidm" >> ~/WallAware/config
echo "netm=$netm" >> ~/WallAware/config
echo "btm=$btm" >> ~/WallAware/config
echo ""
