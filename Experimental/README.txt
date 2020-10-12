README

To use these experimental elements move the entire contents of this folder
except this readme to the main ~/WallAware directory

Copy "WallAware_config_Watcher.plist" to ~/Library/LaunchAgents
and run "launchctl load ~/Library/LaunchAgents/WallAware_config_Watcher.plist"

Now in the main WallAware directory run "settings.sh" from "Config_bin"
OR Manually edit the "config" file. If the LaunchAgent was configured and loaded
correctly then you should now have additional LaunchAgents added to your
~/Library/LaunchAgents directory. Provided the "WallAware_config_Watcher.plist"
LaunchAgent was loaded correctly, any changes made to "config" will automatically
force an update of the launch agents, and script variables to reflect the desired
settings.

I personally am still using Keyboard Maestro as I find it more reliable. However
these launch agents and scripts were a step toward making WallAware "standalone",
and frankly I think it was a success...just not enough of a success.
