#!/bin/bash

ATH_ID="00:0A:45:25:2B:AB"

bluetoothctl power off

# Start service and pair bluetooth headset
bluetoothctl power on
bluetoothctl pair $ATH_ID
bluetoothctl connect $ATH_ID

