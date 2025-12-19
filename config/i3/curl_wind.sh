#!/bin/bash

SB="http://webcam.ichtus.ch:8888/WebApiCoreIchtus/LetsKiteValue"
YV="https://yvbeach.com/yvmeteo.htm"
WSCT="http://thunerwetter.ch/wsct_wind.html"

function get_sb_data {
  local LINES=$( curl $SB -s )
  SB_WIND=$( echo $LINES | jq '((.windSpeedKnotsIchtus*1.852*100|round/100|tostring) + " " + (.windSpeedHigh1KnotsIchtus*1.852*100|round/100|tostring))' | tr '"' ' ' )
  SB_DEG=$( echo $LINES | jq '.windDirectionDegreesIchtus' )
}

function get_yv_data {
  local LINES=$( curl $YV -s | grep -i 'km/h\|DIRECTION' )
  YV_WIND=$( echo $LINES | grep -oP "\\d*\\.\\d" | tr '\n' ' ' )
  YV_DEG=$( echo $LINES | grep -oP "\\d*&deg" | grep -oP "\\d*")
}

function get_wsct_data {
  local LINES=$( curl $WSCT -s | grep 'km/h\|aus' )
  WSCT_WIND=$( echo "$LINES" | grep -oP "\\d*\\.?\\d+" | head -2 | tr '\n' ' ' | sed 's/ *$//' )
  WSCT_DEG=$( echo "$LINES" | grep 'aus' | grep -oP "[A-Z]*" | head -1 )
}

function get_dir_icon () {
  local DEG=$1
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
    ICO=↓
  fi
}

function get_dir_icon2 () {
  local DEG=$1
  if [[ $DEG == "N" ]]; then
    ICO=↓
  elif [[ $DEG == "NO" ]]; then
    ICO=↙
  elif [[ $DEG == "O" ]]; then
    ICO=←
  elif [[ $DEG == "SO" ]]; then
    ICO=↖
  elif [[ $DEG == "S" ]]; then
    ICO=↑
  elif [[ $DEG == "SW" ]]; then
    ICO=↗
  elif [[ $DEG == "W" ]]; then
    ICO=→
  elif [[ $DEG == "NW" ]]; then
    ICO=↘
  else
    ICO=↓
  fi
}

get_sb_data
get_dir_icon $SB_DEG
SB_ICO=$ICO
get_yv_data
get_dir_icon $YV_DEG
YV_ICO=$ICO
get_wsct_data
get_dir_icon2 $WSCT_DEG
WSCT_ICO=$ICO

# Validate and clean up variables
[[ -z "$SB_WIND" ]] && SB_WIND="0 0"
[[ -z "$YV_WIND" ]] && YV_WIND="0 0" 
[[ -z "$WSCT_WIND" ]] && WSCT_WIND="0"
[[ -z "$WSCT_DEG" ]] && WSCT_DEG="N"

echo "🌀 SB$SB_WIND$SB_ICO YV $YV_WIND$YV_ICO TH $WSCT_WIND $WSCT_ICO"

exit 0
