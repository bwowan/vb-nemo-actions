#!/bin/bash

#set -x

if [ $# -ne 1 ]; then
    echo "Использование: $0 <путь_к_каталогу>"; exit 1
fi

inputDir="$1"
if [ ! -d "${inputDir}" ]; then
    echo "Ошибка: Каталог '$inputDir' не существует или не является каталогом."; exit 1
fi

pushd "$inputDir"
plFile="./playlist.m3u"

echo "#EXTM3U" > "$plFile"


ls -1  | grep -E -i '\.(mp3|opus|flac|ogg|m4a|aac|ape)$' | while IFS= read -r file; do
#find . -maxdepth 1 -type f \( -iname "*.mp3" -o -iname "*.opus" -o -iname "*.flac" -o -iname "*.ogg" -o -iname "*.m4a" -o -iname "*.aac" \) | sort -z |  while IFS= read -r file; do
    echo "$file" >> "$plFile"
    echo "$file\n"
done

# Проверяем, были ли найдены аудиофайлы
if [ ! -s "$plFile" ] || [ "$(wc -l < "$plFile")" -eq 1 ]; then
    echo "Ошибка: В каталоге '$inputDir' не найдены аудиофайлы."
    rm "$plFile"
fi

popd


