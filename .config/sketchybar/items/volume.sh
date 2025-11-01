#!/bin/bash

YELLOW=0xffffcc00

sketchybar --add item volume right \
           --set volume label.color=$YELLOW \
                        script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change 
