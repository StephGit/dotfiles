# i3

Install latest i3-Window Manager (Ubuntu repos often not up-to-date):

Get it [here](https://i3wm.org/docs/repositories.html) 


## Required Packages for i3 config

```
sudo apt update
sudo apt install i3status i3lock redshift pulseaudio pavucontrol xbacklight xautolock rofi numlockx flameshot fonts-font-awesome feh lm-sensors
``` 

* i3status
* i3blocks -> Install it manually to make i3blocks work properly -> see https://github.com/vivien/i3blocks#installation
* [redshift](https://github.com/jonls/redshift), color correction
* [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/), volume control
* xbacklight, adjust backlight brightness using RandR extension
* [i3lock](https://github.com/i3/i3lock), screen locker
* xautolock, lock screen if there is no activity
* [rofi](https://github.com/DaveDavenport/rofi), Application launcher and dmenu replacement
* numlockx, turn numlock on at login
* flameshot, screenshot utility

## Required / Suggestions for look & feel


* fonts-font-awesome 
* [Yosemite San Francisco Font](https://github.com/supermarin/YosemiteSanFranciscoFont), install this font to ~/.fonts
* [feh](https://github.com/derf/feh), an image viewer. in the config feh is used to set the wallpaper (default: ~/Pictures/wallpaper.jpg)
* [Arc GTK Theme](https://github.com/horst3180/Arc-theme) 
* [Moka Icon Theme](https://snwh.org/moka)
* [Compton](https://github.com/chjj/compton), provides compositing functionality

## Nautilus 
To disable the nautilus desktop window, use:
`gsettings set org.gnome.desktop.background show-desktop-icons false`

# Troubleshooting 

## Fix Brightness-Control Issue with Intel-Backlight

If the backlight-controls are not working, even with xbacklight or light or whatever. The following steps resolved my issues:

1. Check if intel video-card is used by your system:
``` bash
ls /sys/class/backlight/
intel_backlight@
```
2. Create the file `/usr/share/X11/xorg.conf.d/20-intel.conf`:
```bash
Section "Device"
        Identifier  "card0"
        Driver      "intel"
        Option      "Backlight"  "intel_backlight"
        BusID       "PCI:0:2:0"
EndSection
```
3. Restart and tadaa...

