#!/bin/bash

chenable=$(sed -n 4p ~/WallAware/config | sed 's/[^0-9]//g')
ssidm=$(sed -n 6p ~/WallAware/config | sed 's/[^0-9]//g')
netm=$(sed -n 7p ~/WallAware/config | sed 's/[^0-9]//g')
btm=$(sed -n 8p ~/WallAware/config | sed 's/[^0-9]//g')

chtime=$(sed -n 5p ~/WallAware/config | sed 's/.*\[\([^]]*\)\].*/\1/g')

####CHANGE TIMER TIME####
plutil -replace StartInterval -integer "$chtime" ~/WallAware/WallAware_Timer.plist
####CHANGE TIMER TIME####

####TIMER####
if [[ "$chenable" == 1 ]];
    then test ! -f ~/Library/LaunchAgents/WallAware_Timer.plist
    if test ! -f ~/Library/LaunchAgents/WallAware_Timer.plist
         then cp ~/WallAware/WallAware_Timer.plist ~/Library/LaunchAgents/
              sleep 2
              launchctl load /Library/LaunchAgents/WallAware_Timer.plist
       else
         launchctl unload ~/Library/LaunchAgents/WallAware_Timer.plist
         sleep 2
         rm ~/Library/LaunchAgents/WallAware_Timer.plist
         sleep 2
         cp ~/WallAware/WallAware_Timer.plist ~/Library/LaunchAgents/
         sleep 2
         launchctl load ~/Library/LaunchAgents/WallAware_Timer.plist
       fi
fi

if [[ "$chenable" == 0 ]];
    then test -f /Library/LaunchAgents/WallAware_Timer.plist
    if test -f /Library/LaunchAgents/WallAware_Timer.plist
         then launchctl unload ~/Library/LaunchAgents/WallAware_Timer.plist
          sleep 2
              rm ~/Library/LaunchAgents/WallAware_Timer.plist
       else :
       fi
fi
####TIMER####

####SSID####
if [[ "$ssidm" == 1 ]];
    then test ! -f ~/Library/LaunchAgents/WallAware_WiFi_Watcher.plist
    if test ! -f ~/Library/LaunchAgents/WallAware_WiFi_Watcher.plist
         then  cp ~/WallAware/WallAware_WiFi_Watcher.plist ~/Library/LaunchAgents/
          sleep 2
               launchctl load ~/Library/LaunchAgents/WallAware_WiFi_Watcher.plist
       else :
       fi
fi

if [[ "$ssidm" == 0 ]];
    then test -f ~/Library/LaunchAgents/WallAware_WiFi_Watcher.plist
    if test -f ~/Library/LaunchAgents/WallAware_WiFi_Watcher.plist
         then  launchctl unload ~/Library/LaunchAgents/WallAware_WiFi_Watcher.plist
          sleep 2
               rm ~/Library/LaunchAgents/WallAware_WiFi_Watcher.plist
       else :
       fi
fi
####SSID####

####NETWORK####
if [[ "$netm" == 1 ]];
    then test ! -f ~/Library/LaunchAgents/WallAware_Network_Watcher.plist
    if test ! -f ~/Library/LaunchAgents/WallAware_Network_Watcher.plist
         then  cp ~/WallAware/WallAware_Network_Watcher.plist ~/Library/LaunchAgents/
          sleep 2
               launchctl load ~/Library/LaunchAgents/WallAware_Network_Watcher.plist
       else :
       fi
fi

if [[ "$netm" == 0 ]];
    then test -f ~/Library/LaunchAgents/WallAware_Network_Watcher.plist
    if test -f ~/Library/LaunchAgents/WallAware_Network_Watcher.plist
         then  launchctl unload ~/Library/LaunchAgents/WallAware_Network_Watcher.plist
          sleep 2
               rm ~/Library/LaunchAgents/WallAware_Network_Watcher.plist
       else :
       fi
fi
####NETWORK####

####BLIUETOOTH####
if [[ "$btm" == 1 ]];
    then test ! -f ~/Library/LaunchAgents/WallAware_Bluetooth_Watcher.plist
    if test ! -f ~/Library/LaunchAgents/WallAware_Bluetooth_Watcher.plist
         then  cp ~/WallAware/WallAware_Bluetooth_Watcher.plist ~/Library/LaunchAgents/
          sleep 2
               launchctl load ~/Library/LaunchAgents/WallAware_Bluetooth_Watcher.plist
       else :
       fi
fi

if [[ "$btm" == 0 ]];
    then test -f ~/Library/LaunchAgents/WallAware_Bluetooth_Watcher.plist
    if test -f ~/Library/LaunchAgents/WallAware_Bluetooth_Watcher.plist
         then  launchctl unload ~/Library/LaunchAgents/WallAware_Bluetooth_Watcher.plist
          sleep 2
               rm ~/Library/LaunchAgents/WallAware_Bluetooth_Watcher.plist
       else :
       fi
fi
####BLUETOOTH####








exit 0;
