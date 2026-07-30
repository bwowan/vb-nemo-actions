#!/bin/bash

file_name=("$@")
dir_name=$(dirname "${file_name[0]}")

if ! dir_name=$(zenity --entry --title="Распаковка архива" --text="Введите куда извлекать:" --entry-text="$dir_name"); then
    exit 1
fi

if ! mkdir -p "$dir_name"; then
    zenity --error --text="Каталог назначения недоступен!"
    exit 1
fi

7zz x -bb3 -o"${dir_name}" "${file_name[@]}"
read -r
