# WallAware
WiFi aware wallpaper changer for macOS. This was created to run on macOS and does contain bits of AppleScript. So out of the box it will not run on Linux. 

However, im sure it would take about 5min of googling to adapt it to your desktop environment and have it working fine. 
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

# Getting the most out of WallAware.
1. Make sure the WallAware folder is in your users home folder, this is where the scripts expect everything to be. 
2. If you want your "A" wallpaper to be the macOS default wallpaper, or whatever you had last set in System Preferences, then leave the "A" folder empty. 
3. I highly recommend combining my script with Keyboard Maestro, its affordable, and works beautifully to trigger the WallAware scripts to make a seamless experience. I will include my Macros in the download. I have created a macro to run the script on each wake, each time wifi connects or disconnects, and created one that runs every 30min (this is just to get a fresh background every 30min, you can remove it if you want.) Lastly, I created one last macro that runs a seperate script called `Add_Network.sh`, I will explain this in more detail below. 
4. Check the .sh files in a text editor, they contain their own read-me sections and options. 
5. WallAware will pull images from sub folders too, so you can keep your wallpapers organized if you wish. It will also follow symlinks now too! 
6. Check the top of the WallAware.sh file for new user changeable options.
7. I highly reccomend using the BitBar plugin, it adds many common commands along with the current status to a simple menubar app.

## Add Networks Script
This script allows you to add new SSIDs to the SSID list and then it will automatically run the main script to switch to a A wallpaper. 

This script performs the following actions;
1. Checks SSID and compares it to the list
2. If it is in the list then it just runs `wallaware.sh` and does nothing else.
3. If it is not in the list then it adds it to the list and then runs `wallaware.sh` .

I personally keep this script in a hotkey macro in Keyboard Maestro, so if need be it only a key combo away at any time.  

## Remove Networks Script
This script allows you to remove the current SSID from the list, it will then automatically run the main script switching you to a B wallaper. 

This script performs the following actions;
1. Checks SSID and compares it to the list
2. If it is not in the list then it does nothing.
3. If it is is in the list then it removes it from the list and then runs `wallaware.sh`.

I personally run this script from the BitBar menu wehen needed. 

## Additional Info

**RANDOMNESS**
I had a hard time finding a way to randomize the images without getting a lot of repeats. Everything I Googled involved a solution that was way over my head. So I ended up using the `touch` command to update the file access time, ~~and then told the script to prioritize files with an access time over 1 day, OR a modified time of less than 1. This should ensure that you never repeat the same wallpaper more than once a day, and that new images will initially get a small priority.~~ 

That didnt work at all, it ended up creating a situation where new wallpapers never get introduced into the rotation. The process now checks to see if there are any new wallpapers first and will show them first, it will then check to see if there are any older than a set number of days (this can be changed by the user), the hope for this is to prevent seeing the same wallpaper too often but to always get new wallpapers into rotation. Finally if both of the above return no result then a wallpaper will just be chosen at random. 

**THE FUTURE**
As I said before I'm not a programmer, and I likely never will be professionally. I did however really enjoy creating this, it was a lot of fun getting create something myself that was actually useful. 

I would love to continue learning and get to a point where WallAware becomes completely self contained, so no more Keyboard Maestro required. 

I would also love to create a small GUI, probably a tray indicator at first, that allows you to add/remove SSIDs, and change wallpapers forward and back manually. 

I currently have no idea where to start on any of that though, so it'll likely be a while. However I do intend on continuing to use this script for the foreseeable future, and will keep it up to date and working for likely a long time to come. 
