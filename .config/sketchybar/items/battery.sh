#!/bin/bash

YELLOW=0xffffcc00

sketchybar --add item battery right \
           --set battery update_freq=120 \
                         label.color=$YELLOW \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
