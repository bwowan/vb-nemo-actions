#!/bin/bash

file_name=("$@")
dir_name=$(dirname "$file_name")

dir_name=$(zenity --entry --title="Распаковка архива" --text="Введите куда извлекать:" --entry-text="$dir_name")
if [ $? -ne 0 ]; then
    exit 1
fi

mkdir -p "$dir_name"
if [ $? -ne 0 ]; then
    zenity --error --text="Каталог назначения недоступен!"
    exit 1
fi

7zz x -bb3 -o"${dir_name}" "${file_name}"
read 

