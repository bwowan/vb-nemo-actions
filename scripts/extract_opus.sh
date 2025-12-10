#!/bin/bash
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")") # Get script directory
files=("$@")
for i in ${!files[@]}; do
  f=${files[$i]}
  fout="${f%.*}.opus"
  ffmpeg -hide_banner -stats -loglevel warning -i "$f" -c:v none -c:a libopus -ac 1 -b:a 48k -vbr on -compression_level 10 "$fout"
  "$script_dir/notify_out.sh" $? "$fout"
done
