#!/bin/bash

file_name="$(rofi -dmenu -window-title "File-Name:")"


if [[ "$file_name" != "" ]]
then
    wl-paste > "/tmp/$file_name"
    dragon "/tmp/$file_name"
fi
