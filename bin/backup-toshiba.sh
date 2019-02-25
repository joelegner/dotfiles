#!/bin/bash

# Get current quarter
MONTH=$(date '+%m')
QUARTER='Q1'
if (( 10#$MONTH > 3 )); then QUARTER='Q2'; fi
if (( 10#$MONTH > 6 )); then QUARTER='Q3'; fi
if (( 10#$MONTH > 9 )); then QUARTER='Q4'; fi

echo $QUARTER

# Back up Dropbox to external Toshiba drive
rsync -avX --delete /media/family/GoogleOne /run/media/joe/TOSHIBA\ EXT/backups/GoogleOne/$QUARTER/

