#!/bin/bash
#Get new name
NAME=$(zenity --entry --width=250 --title "File name" --text="Confirm new filename" --entry-text="$3" )
if [ -z "$NAME" ]; then
  exit 1; 
fi
#Check not overwriting an existing file or directory
if [ -e "$2/$NAME" ]; then
  zenity --info --width=250 --text="Error. $2/$NAME already exists. Try again."
  exit 1
fi
#Is location writeable?
if [ ! -w "$2" ] ; then
  PASS=$(zenity --password --title="Authenticate to rename.")
  echo -e "$PASS" | sudo -S mv "$1" "$2/$NAME"
else
  mv "$1" "$2/$NAME"
fi
if [ $? = 1 ]; then
  zenity --info --width=250 --text="Error renaming $1. Try again."
  exit 1
else
  notify-send --expire-time=200000 "Successfully renamed $1 to $2/$NAME"
  exit 0
fi
