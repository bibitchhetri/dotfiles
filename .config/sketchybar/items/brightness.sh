#!/bin/bash

sketchybar --add item brightness right \
           --set brightness icon.color=$WHITE \
                            label.color=$RED_PINK \
                            icon=􀆨 \
                            update_freq=5 \
                            script="$PLUGIN_DIR/brightness.sh"

