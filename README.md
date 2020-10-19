
# WallAware
WiFi aware wallpaper changer for macOS. 
## History
So I'm going to start-out right off the bat by saying I am not a programmer in any sense of the word. I wanted a program that didn't exist so I created it in the most rudimentary way possible. 
## What does WallAware Do?
Simple, WallAware by itself will;
1. Check to see what your current SSID is.
2. Check that SSID against a list of predefined SSIDs
3. If the current SSID is found in the list then WallAware will set a random wallpaper from the "A" folder.
4. If the current SSID is not found then it will determine if you are even connected to WiFi, if not then it will set a random wallpaper from the "A" folder. If WiFi is enabled and the SSID is not in the list then it will randomly set a wallpaper from the "B" folder. 
## Why?
Mostly because I am a hobbyist graphic designer, and my work isn't always work appropriate. I however use my personal Mac Book Pro at work every day, and don't want to manually change my wallpaper twice a day. 

# Getting WallAware setup.

Wallaware is designed to be modular as to allow the end user to interact with it in their own way. The core of Wallaware is broken up into 4 main scripts that can be triggered or ran by just about anything you can think of. 

**SCRIPTS:**
1. Wallaware: This is the core of everything, this is the script that obtains the SSIDs and checks the list, then decides on which wallpaper to set. 
2. Add_Network: This script obtains the current SSID and adds it to the list while setting a Wallpaper from "Directory A"
3. Remove_Network: This script obtains the current SSID, and removes it from the list while setting a wallpaper from "Directory B"
4. Toggle_Network: This essentially combines the actions of "1" and "2" into a single script that can be ran over and over to toggle a network as black listed or not. 

**SETTING IT ALL UP:**

**The Basics:**
This is going to descrivbe how to setup Wallaware to match my personal setup, and how I intended it to run. However, this is just a collection of shell scripts, you do not have to set it up exactly like mine. if there is a required step I will put it in *italics*.

1. *Extract the .zip file and place the "Wallaware" folder in your home directory.* 
2. *Place your desired wallpapers in the A and B folders. (A is what is selected if an SSID is NOT listed.) You can also customize where the A and B directories pull from by changing the variables at the top of the `wallaware.sh` file.* 

Do note: the Wallaware folder MUST be located in your user home directory or things will not run correctly, if at all. 

That's it for a basic setup, you could now execute the various scripts and see WallAware do its thing...but it doesn't do it automatically yet, lets fix that. 

**Make it Automatic:**
To trigger the scripts automatically when they are needed I prefer to use a program called "[Keyboard Maestro](https://www.keyboardmaestro.com/main/#Overview)", It is paid, but its affordable, does exactly what we need, and is incredibly reliable. 

I have included a file called `WallAware  Macros.kmmacros` this is an export of my macros I use for Wallaware. Just import that file into your Keyboard Maestro program by double clicking it. 

Here is what the various macros do:
1. On Wake: This macros is disabled my default. But if enabled it will trigger the main script to run when the screen wakes from sleep. 
2. Timer: This runs the main script on a set timer. it serves no purpose other than to periodically change the wallpaper. if you do not want your wallpaper to change every so often then disable this one. 
3. ToggleNetwork: This one is more important, it is assigned to `Control Option Command Space` and it will immediately run `Toggle_Network`. This allows you to quickly black list or whitelist an SSID on demand. 
4. WiFi Connect: Runs the main script when WiFi is connected, this is considered a "core function". 
5. WiFi Disconnect: Runs the main script when WiFi is disconnected, this is also considered a "core function". 

Macros "4" and "5" are essentially the whole point of Wallaware, however you can customize any of this to your liking. 

**Give it a nice simple GUI:**
This is one of my favorite additions, a [Bitbar](https://github.com/matryer/bitbar) plugin. Bitbar is a fantastic free utility to add scripts to your macOS menu bar very easily. This allows Wallaware to have a nice simple UI. 

The Wallaware plugin allows you to:
1. See the current SSID
2. Change to the next wallpaper on demand
3. Add the current SSID to the list.
4. Remove the current SSID from the list. 

To install is simple, just install and run Bitbar, then change your plugin directory to the Bitbar folder contained inside the Wallaware folder. 

If you already run Bitbar, then just copy my script from the Bitbar folder and place it where ever you'd like. 

**Put your Touchbar to good use:**
This one was more of  a "because i can" kind of thing, but it has proven useful. 

First you must install [Better Touch Tool](https://folivora.ai/), again its paid but affordable and is reliable. Once installed double click on the `WallAware.bttpreset` file to install the macros. That should be it.

What does it do?

1. Toggle SSID list status
2. Change to next wallpaper on demand.

It uses the same hot key combo and Keyboard Maestro minus the spacebar. 

So you hold `control option command` and youll see 2 Wallaware icons apear on your touch bar `toggle` and `next`. 
