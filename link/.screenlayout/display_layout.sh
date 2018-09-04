#!/bin/bash

set -e 

function find_default_monitor {
  CONNECTED_MONITORS=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
  for monitor in $CONNECTED_MONITORS; do
    if [ $monitor = 'eDP-1' ] || [ $monitor = 'LVDS-1'];
    then
      echo $monitor
      exit
    fi;
  done
}


# This variables are used as keys in the associative arrays below
MONITOR_INTERNAL=INTERNAL
MONITOR_HDMI=HDMI
MONITOR_THUNDERBOLT=TB

# Screen names (use xrandr to find them out)
SCREEN_INTERNAL_DISPLAY=eDP-1
SCREEN_INTERNAL_VIDEO=LVDS-1
SCREEN_HDMI=DP-1-1
SCREEN_TB=DP-1-2
SCREEN_INTERNAL="$(find_default_monitor)"

# Default monitor is the internal monitor
MONITOR=$SCREEN_INTERNAL

# The configs for the displays are stores in the following associative arrays
declare -A monitor_screens
monitor_screens=([$MONITOR_INTERNAL]=$SCREEN_INTERNAL [$MONITOR_HDMI]=$SCREEN_HDMI [$MONITOR_THUNDERBOLT]=$SCREEN_TB)

declare -A monitor_scripts
monitor_scripts=([$MONITOR_INTERNAL]="1internal_$SCREEN_INTERNAL.sh" [$MONITOR_HDMI]="1external_hdmi.sh" [$MONITOR_THUNDERBOLT]="2external.sh")

#declare -A xresources_files
#xresources_files=([$MONITOR_INTERNAL]="Xresources-internal-display" [$MONITOR_DP]="Xresources-external-display" [$MONITOR_HDMI]="Xresources-external-display" [$MONITOR_THUNDERBOLT]="Xresources-external-display")

#declare -A xrandr_dpis
#xrandr_dpis=([$MONITOR_INTERNAL]="180" [$MONITOR_DP]="110" [$MONITOR_HDMI]="110" [$MONITOR_THUNDERBOLT]="110")


function do_activate_monitor {
    monitor_to_activate=$1
    xrandr_script="$HOME/.screenlayout/${monitor_scripts[$1]}"
    # xresources_file="$HOME/.screenlayout/${xresources_files[$1]}"
    # xrandr_dpi=${xrandr_dpis[$1]}

    echo "Switching to $monitor_to_activate"
    echo "execute $xrandr_script"
    /bin/bash $xrandr_script
    # echo "copy $xresources_file to $HOME/.Xresources for the Xft.dpi variable (used for xrvt etc...)"
    # cp $xresources_file $HOME/.Xresources
    # echo "set xrandr --dpi $xrandr_dpi, used by i3" 
    # xrandr --dpi $xrandr_dpi
    MONITOR=$monitor_to_activate
}

function is_monitor_active {
    [ $MONITOR == "$1" ]
}

function is_screen_connected {
    ! xrandr | grep "$1" | grep disconnected
}

# Iterate over all keys [HDMI, DP, TB INTERNAL]
for monitor in $MONITOR_THUNDERBOLT $MONITOR_HDMI $MONITOR_INTERNAL; do
  echo "checking configured monitor $monitor (${monitor_screens[$monitor]})"
  if ! is_monitor_active $monitor && is_screen_connected "${monitor_screens[$monitor]}"
  then
    echo "$monitor (${monitor_screens[$monitor]}) is connected"
    do_activate_monitor $monitor
#   ~/.dotfiles/util/set-mouse-acceleration.sh
     break
  else
    printf "$monitor (${monitor_screens[$monitor]}) is not connected\n"
  fi
done

i3-msg reload
i3-msg restart
