#!/bin/bash
# Script for selecting an item from a list using zenity
# Usage: zenity_select.sh "Title" "Text" "Column Name" "option1" "option2" ...
# Returns: selected value or empty string if cancelled

if [ $# -lt 4 ]; then
    exit 1
fi

strTitle="$1"
strText="$2"
strColumn="$3"
shift 3
options=("$@")

# Build zenity options list and request selection via zenity
zenity_options=()
for i in "${!options[@]}"; do
    zenity_options+=("$((i+1))" "${options[i]}")
done
choice=$(zenity --list --title=strTitle --text=strText --column=strColumn "${zenity_options[@]}" \
                --width=400 --height=300 --modal)
if [ -z "$choice" ]; then
    exit 1
fi

choice_index=$((choice - 1))     # Convert selection to array index (zenity returns number, need to subtract 1)
echo "${options[$choice_index]}" # Output selected value

