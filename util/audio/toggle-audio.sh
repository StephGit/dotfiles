#!/bin/bash

pulseaudio

# Get a a list of all sinks
sinks=$(pactl list short sinks | cut -f 2)

for sink in $sinks; do
  cmd="pactl set-sink-mute $sink toggle"
  echo "executing: $cmd"
  eval $cmd
done
