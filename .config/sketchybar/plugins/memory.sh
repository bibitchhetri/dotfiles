#!/bin/bash

# Get memory usage percentage using vm_stat
MEMORY_INFO=$(vm_stat | perl -ne '
  /page size of (\d+)/ and $size=$1;
  /Pages\s+([^:]+)[^\d]+(\d+)/ and $mem{$1}=$2;
  END {
    $total = ($mem{free} + $mem{active} + $mem{inactive} + $mem{wired} + ($mem{speculative} || 0)) * $size;
    $used = ($mem{active} + $mem{inactive} + $mem{wired} + ($mem{speculative} || 0)) * $size;
    if ($total > 0) {
      printf "%.0f", ($used / $total) * 100;
    } else {
      print "0";
    }
  }
')

if [ -z "$MEMORY_INFO" ] || [ "$MEMORY_INFO" = "" ]; then
  # Fallback method
  MEMORY_PERCENT=$(ps aux | awk 'NR>1 {sum+=$4} END {printf "%.0f", sum}')
else
  MEMORY_PERCENT=$MEMORY_INFO
fi

sketchybar --set $NAME label="${MEMORY_PERCENT}%"

