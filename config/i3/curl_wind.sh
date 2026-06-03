#!/bin/bash

SB="http://webcam.ichtus.ch:8888/WebApiCoreIchtus/LetsKiteValue"
YV="https://yvbeach.com/yvmeteo.htm"
WSCT="https://www.thunerwetter.ch/current_sb.xml"
SCNI="https://www.meteomap.cloud/1088/get/chart/wind?tf=current"

function get_sb_data {
  local LINES=$( curl $SB -s )
  SB_WIND=$( echo $LINES | jq '((.windSpeedKnotsIchtus|round|tostring) + " " + (.windSpeedHigh1KnotsIchtus|round|tostring))' | tr '"' ' ' )
  SB_DEG=$( echo $LINES | jq '.windDirectionDegreesIchtus' )
}

function get_yv_data {
  local LINES=$( curl $YV -s | grep -i 'km/h\|DIRECTION' )
  YV_WIND=$( echo $LINES | grep -oP "\\d*\\.\\d" | awk '{printf "%d ", $1/1.852}' )
  YV_DEG=$( echo $LINES | grep -oP "\\d*&deg" | grep -oP "\\d*")
}

function get_scni_data {
  local RESPONSE=$( curl $SCNI -s )
  local LAST_Y=$( echo $RESPONSE | jq -r '.data.data[-1].y' )
  local HOURLY_DIR=$( echo $RESPONSE | jq -r '.data.hourlyDir' )
  local LAST_DIR_MATCH=$( echo $HOURLY_DIR | grep -oP 'title="[^"]*"' | tail -1 )
  local DIR_PART=$( echo $LAST_DIR_MATCH | grep -oP ': \K[^"]+' )
  SCNI_WIND=$( echo "$LAST_Y" | awk '{printf "%d", $1/1.852, 0}' )
  SCNI_DIR="$DIR_PART"
}

function get_wsct_data {
  local LINES=$( curl $WSCT -s )
  local WIND=$( echo "$LINES" | grep -oP '<windkts>\K[^<]+' )
  local GUST=$( echo "$LINES" | grep -oP '<windgustkts>\K[^<]+' )
  WSCT_WIND="$WIND $GUST"
  WSCT_DEG=$( echo "$LINES" | grep -oP '<curval_winddir>\K[^<]+' )
}

function get_dir_icon3 () {
  local DIR=$1
  case "$DIR" in
    N)   ICO=↓ ;;
    NNE) ICO=↙ ;;
    NE)  ICO=↙ ;;
    ENE) ICO=← ;;
    E)   ICO=← ;;
    ESE) ICO=↖ ;;
    SE)  ICO=↖ ;;
    SSE) ICO=↑ ;;
    S)   ICO=↑ ;;
    SSW) ICO=↗ ;;
    SW)  ICO=↗ ;;
    WSW) ICO=→ ;;
    W)   ICO=→ ;;
    WNW) ICO=↘ ;;
    NW)  ICO=↘ ;;
    NNW) ICO=↓ ;;
    *)   ICO=↓ ;;
  esac
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
get_scni_data
get_dir_icon3 $SCNI_DIR
SCNI_ICO=$ICO
get_wsct_data
get_dir_icon $WSCT_DEG
WSCT_ICO=$ICO

function colorize {
  local LABEL=$1
  local WIND=$2
  local ICO=$3
  local VAL=$( echo "$WIND" | awk '{print $1}' )
  if [[ $VAL -gt 15 ]]; then
    echo "<span color=\"red\">$LABEL$WIND $ICO</span>"
  else
    echo "$LABEL$WIND $ICO"
  fi
}

# Validate and clean up variables
[[ -z "$SB_WIND" ]] && SB_WIND="0 0"
[[ -z "$YV_WIND" ]] && YV_WIND="0 0" 
[[ -z "$WSCT_WIND" ]] && WSCT_WIND="0 0"
[[ -z "$WSCT_DEG" ]] && WSCT_DEG="N"
[[ -z "$SCNI_WIND" ]] && SCNI_WIND="0"
[[ -z "$SCNI_DIR" ]] && SCNI_DIR="N"

C_SB=$( colorize "SB" "$SB_WIND" "$SB_ICO" )
C_YV=$( colorize "YV " "$YV_WIND" "$YV_ICO" )
C_TH=$( colorize "TH " "$WSCT_WIND" "$WSCT_ICO" )
C_INT=$( colorize "INT " "$SCNI_WIND" "$SCNI_ICO" )
echo "🌀 $C_SB $C_YV $C_TH $C_INT"

exit 0
