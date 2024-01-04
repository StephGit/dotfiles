#!/bin/bash

ATH_ID="00:0A:45:25:2B:AB"

bluetoothctl remove $ATH_ID
bluetoothctl scan on
bluetoothctl pair $ATH_ID
bluetoothctl connect $ATH_ID
