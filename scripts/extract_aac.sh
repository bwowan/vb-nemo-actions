#!/bin/bash
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")") # Get script directory
files=("$@")
for i in ${!files[@]}; do
  f=${files[$i]}
  fout="${f%.*}.aac"
  ffmpeg -hide_banner -stats -loglevel warning -i "$f" -c:v none -c:a copy "$fout"
  "$script_dir/notify_out.sh" $? "$fout"
done

