#!/bin/bash

REDDISH_PINK=0xffff69b4

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon=􀧓  \
                      label.color=$REDDISH_PINK \
                      script="$PLUGIN_DIR/cpu.sh"
