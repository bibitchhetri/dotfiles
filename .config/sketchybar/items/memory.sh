#!/bin/bash

LIGHT_BLUE_CYAN=0xff88c0d0

sketchybar --add item memory right \
           --set memory icon.color=$WHITE \
                        label.color=$LIGHT_BLUE_CYAN \
                        icon=􀟥 \
                        update_freq=2 \
                        script="$PLUGIN_DIR/memory.sh"

