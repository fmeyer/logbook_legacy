#!/bin/bash

cd ~/code/logdata.wiki/ || exit

TS=$(date +'%H:%M:%S')
DS=$(date +'%Y-%m-%d')
YEAR=$(date +'%Y')
CURRENT_LOG_DIR="logs/$YEAR/"

# check if current log year exists, creates if no
if [ ! -d "$CURRENT_LOG_DIR" ]; then
  mkdir -p "$CURRENT_LOG_DIR"
fi

# check if the first paramether is a note, otherwise points to
# a log entry
if [[ -n $1 ]]; then
  FILENAME=notes/$1.md
else
  FILENAME=logs/$YEAR/$DS.md
fi

# appends the current date and timestamp to the end of the file
printf "\n**%s**\n" "$DS $TS" >> "$FILENAME"

# starts vim without loading any plugins, starts the cursor at the end of the file 
# and don't create a swap file
vim -u NONE + -n --noplugin "$FILENAME" && git add . && git commit -am "Updating $FILENAME entry on $TS" && git push
