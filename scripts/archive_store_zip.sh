#!/bin/bash

# Сохраняем путь к директории скрипта
script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

files=("$@")

if [ ${#files[@]} -eq 0 ]; then
    zenity --error --text="Не выбраны файлы для архивации!"
    exit 1
fi

first=${files[0]}
archive_dir=$(dirname "$first")
archive_name=$(basename "$first")
archive_name=$archive_dir"/"${archive_name%.*}".zip"
archive_name=$(zenity --entry --title="Создание 7Z архива" --text="Введите имя:" --entry-text="$archive_name")
if [ -z "$archive_name" ]; then
    exit 1
fi

for i in ${!files[@]}; do 
  files[$i]=$(basename "${files[$i]}")
done
cd "$archive_dir"
7zz a -r -tzip -bt -mx=0 -scrcXXH64 -bb3 -snh -snl -spf2 "$archive_name" "${files[@]}" 
"$script_dir/notify_out.sh" $? "$archive_name"

