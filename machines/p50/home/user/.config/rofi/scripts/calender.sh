#!/bin/sh
# Parse `cal` output to rofi. Based from totoro-ghost's rofi-cal works.
# See original work: https://github.com/totoro-ghost/rofi-cal

set -e

case "$1" in
--popup)
    # remove 2 lines from the top
    MAIN=$(cal| awk 'NR>2 {print}')

    SUN=$(echo "$MAIN" | cut -c 1,2)
    MON=$(echo "$MAIN" | cut -c 4,5)
    TUE=$(echo "$MAIN" | cut -c 7,8)
    WED=$(echo "$MAIN" | cut -c 10,11)
    THR=$(echo "$MAIN" | cut -c 13,14)
    FRI=$(echo "$MAIN" | cut -c 16,17)
    SAT=$(echo "$MAIN" | cut -c 19,20)

    VAL="$SUN\n$MON\n$TUE\n$WED\n$THR\n$FRI\n$SAT"

    DATE=$(date +'%_d')
    DAY_STR=$(date +'%A')
    MONTH_STR=$(date +'%b')
    YEAR=$(date +'%Y')

    PROMPT="$DAY_STR, $MONTH_STR, $DATE $YEAR"

    # make current date active
    ACTIVE=$(echo "$VAL" | grep -m 1 -n "$DATE" | cut -d':' -f1)
    ACTIVE=$((ACTIVE - 1))

    # for printing su mo tu we th fr sa, 
    # you have to fix this every time you change the size in theme
    PROMPT2="  <span foreground=\"#e06b74\"><b>Su</b></span>  <b>Mo  Tu   We  Th   Fr  Sa</b>"

    echo "$VAL" | rofi -dmenu -no-custom -mesg "$PROMPT2" \
        -theme "calender" \
        -matching prefix \
        -select "$DATE" \
        -u "0,1,2,3,4,5" \
        -a "$ACTIVE" \
        -p "    $PROMPT"
    exit 0
    ;;
*)
    date +" %H:%M"
    ;;
esac
