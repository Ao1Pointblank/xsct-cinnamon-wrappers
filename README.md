# xsct-cinnamon-wrappers
Use XSCT to control brightness and temperature on Cinnamon DE. YAD menu and Cinnamon OSD integration.  
depends on: xsct, yad, bc, wmctrl  


# XSCT-OSD TL;DR:  

``xsct-osd.sh [brightness|temperature] [up|down|reset]``  

will change brightness in increments of 5% in a range from 10% - 100%  
will change temperature in steps of 250K in a range from 1000K - 6500K  
  
displays cinnamon's gdbus OSD to graphically represent changes   

```
# Usage:
# ./xsct-osd.sh <mode> <direction>
#
# Parameters:
# - <mode>: Specifies the setting to adjust. Available modes:
#   - brightness: Adjusts the screen brightness.
#   - temperature: Adjusts the screen color temperature.
#
# - <direction>: Specifies the adjustment direction. Available directions:
#   - up: Increases the setting value.
#   - down: Decreases the setting value.
#   - reset: Resets the setting to its default value.
#
# Examples:
# - Increase Brightness: ./xsct-osd.sh brightness up
# - Decrease Temperature: ./xsct-osd.sh temperature down
# - Reset Temperature to Default: ./xsct-osd.sh temperature reset
#
# Requires:
# bc (bash calculator) and xsct installed and in $PATH
# this script probably only works on Cinnamon with X11
```

# XSCT-YAD TL;DR:
``xsct-yad.sh [brightness|temperature]``  
  
more universal slider interface for xsct than the cinnamon OSD.  
swaps between two slider windows at the click of one button. 
adjust values with < > or pgup pgdwn when window is in focus; esc to close - works well with controllers through antimicrox  
i also suggest adding it to your panel with a Cinnamon applet like Command Launcher ([commandLauncher@scollins](https://cinnamon-spices.linuxmint.com/applets/view/139))
