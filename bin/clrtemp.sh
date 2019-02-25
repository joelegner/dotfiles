#!/bin/bash
# Clear out temp files
find /home/joe/temp/* -exec rm -Rf {} \;
touch /home/joe/temp/_files_deleted_at_midnight

