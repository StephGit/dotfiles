#!/bin/bash

PAGE="http://yvbeach.com/yvmeteo.htm"

function get_wind_data {
  LINES=$( curl $PAGE -s | grep -i 'km/h\|DIRECTION' )
  WIND=$( echo $LINES | grep -oP "\\d*\\.\\d" | tr '\n' ' ' )
  DEG=$( echo $LINES | grep -oP "\\d*&deg" | grep -oP "\\d*")
}

function get_dir_icon {
  if [[ $DEG -gt 339 && $DEG -lt 25 ]]; then
    ICO=↓
  elif [[ $DEG -gt 24 && $DEG -lt 70 ]]; then
    ICO=↙
  elif [[ $DEG -gt 69 && $DEG -lt 115 ]]; then
    ICO=←
  elif [[ $DEG -gt 114 && $DEG -lt 160 ]]; then
    ICO=↖
  elif [[ $DEG -gt 159 && $DEG -lt 205 ]]; then
    ICO=↑
  elif [[ $DEG -gt 204 && $DEG -lt 250 ]]; then
    ICO=↗
  elif [[ $DEG -gt 249 && $DEG -lt 295 ]]; then
    ICO=→
  elif [[ $DEG -gt 294 && $DEG -lt 340 ]]; then
    ICO=↘
  else
    ICO=
  fi
}

get_wind_data
get_dir_icon

echo "$WIND$ICO"

exit 0
