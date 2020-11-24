#!/bin/bash

# Back up Dropbox to external Toshiba drive
rsync -av --delete /Users/joelegner/Google\ Drive /Volumes/TOSHIBA\ EXT/backups/
