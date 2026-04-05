#!/bin/bash

BRIGHTNESS_FILE="/tmp/${USER}${DISPLAY}.xsct-osd-bright"
TEMPERATURE_FILE="/tmp/${USER}${DISPLAY}.xsct-osd-temp"

XSCT_PATH="/usr/bin/xsct"
[[ -x "$XSCT_PATH" ]] || { yad --error --text="xsct not found"; exit 1; }

cleanup() {
    # Get all windows with class containing 'yad_xsct'
    wmctrl -l -x | awk '$3 ~ /yad_xsct/ {print $1}' | while read win_id; do
        wmctrl -i -c "$win_id"
    done
}

shared_options=(
    --scale
    --inc-buttons
    --class="yad_xsct"
    --window-icon=/home/pointblank/.icons/Tela-circle-yellow/scalable/apps/applications-system.svg
    --text-align=center
    --sticky
    --on-top
    --fixed
    --enforce-step
    --print-partial
    --window-type=dialog
    --geometry=500x100-6-0
)

yad_brightness() {
    cleanup
    yad \
        --title="Brightness" \
        --text="Adjust Brightness from 10% to 100%" \
        --min-value=10 \
        --max-value=100 \
        --value="$(cat $BRIGHTNESS_FILE)" \
        --step=5 \
        --page=10 \
        --inc-buttons \
        --button="Temperature:bash -c 'kill -SIGUSR1 \$YAD_PID & $0 temperature &' &" \
        --float-precision=2 \
        "${shared_options[@]}" |
    while read -r value; do
        float_value=$(echo "scale=2; $value / 100" | bc)
        echo "$value" > "$BRIGHTNESS_FILE"
        "$XSCT_PATH" "$(cat $TEMPERATURE_FILE)" "$float_value" || yad --error --text="Failed to apply $value"
    done
}

yad_temperature() {
    cleanup
    yad \
        --title="Temperature" \
        --text="Adjust Temperature from 1000K to 6500K" \
        --min-value=1000 \
        --max-value=6500 \
        --value="$(cat $TEMPERATURE_FILE)" \
        --step=250 \
        --page=500 \
        --button="Brightness:bash -c 'kill -SIGUSR1 \$YAD_PID & $0 brightness &' &" \
        "${shared_options[@]}" |
    while read -r value; do
        echo "$value" > "$TEMPERATURE_FILE"
        "$XSCT_PATH" "$value" "$(echo "scale=2; $(cat $BRIGHTNESS_FILE) / 100" | bc)" || yad --error --text="Failed to apply $value"
    done
}


case "$1" in
    "brightness")
        yad_brightness
        ;;
    "temperature")
        yad_temperature
        ;;
    *)
        echo "Unknown mode: $1"
        exit 1
        ;;
esac
