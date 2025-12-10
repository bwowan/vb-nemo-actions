#!/bin/bash
#VBR    kbps/channel	AOTs
#1	    20-32           LC,HE,HEv2
#2      32-40           LC,HE,HEv2
#3      48-56           LC,HE,HEv2
#4      64-72           LC
#5      96-112          LC 

script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")") # Get script directory

var_methods=(" -vbr 1" " -vbr 2" " -vbr 3" " -vbr 4" " -vbr 5")
selected_method=$("$script_dir/zenity_select.sh" "Conversion Method Selection" "Select conversion method:" "Method" "${var_methods[@]}")
[ -z "$selected_method" ] && exit 1

var_channel=(" -ac 1" " -ac 2")
selected_channel=$("$script_dir/zenity_select.sh" "Channel Selection" "Select number of channels:" "Channels" "${var_channel[@]}")
[ -z "$selected_channel" ] && exit 1

files=("$@")
for i in ${!files[@]}; do
  f=${files[$i]}
  fout="${f%.*}.aac"
  ffmpeg  -hide_banner -stats -loglevel warning -i "$f" -c:v none -c:a aac $selected_channel $selected_method "$fout"
  "$script_dir/notify_out.sh" $? "$fout"
done
