#!/bin/bash

# Get a a list of all sinks
sinks=$(pactl list sinks short | cut -f 2)

for sink in $sinks; do
  cmd="pactl set-sink-volume $sink +5%"
  echo "executing: $cmd"
  eval $cmd
done
