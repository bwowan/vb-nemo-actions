#!/bin/bash

script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory_path> [directory_path ...]"; exit 1
fi

# Process each directory
for inputDir in "$@"; do
    if [ ! -d "${inputDir}" ]; then
        echo "Error: Directory '$inputDir' does not exist or is not a directory." >&2
        continue
    fi

    pushd "$inputDir" > /dev/null
    plFile="./playlist.m3u"

    # Create playlist header
    echo "#EXTM3U" > "$plFile"

    # Find all audio files, sort by name and add to playlist
    find . -maxdepth 1 -type f \( -iname "*.mp3" -o -iname "*.opus" -o -iname "*.flac" -o -iname "*.ogg" -o -iname "*.m4a" -o -iname "*.aac" -o -iname "*.ape" \) | sort | while IFS= read -r file; do
        # Remove ./ from the beginning of the path
        file="${file#./}"
        echo "$file" >> "$plFile"
    done

    # Check if audio files were found (if file contains only #EXTM3U header)
    if [ "$(wc -l < "$plFile")" -eq 1 ]; then
        echo "Warning: No audio files found in directory '$inputDir'. Playlist not created." >&2
        "$script_dir/notify_out.sh" 1 "Warning: No audio files found in directory '$inputDir'. Playlist not created."
        rm "$plFile"
    else
        echo "Playlist created: $inputDir/playlist.m3u"
        "$script_dir/notify_out.sh" 0 "$inputDir/playlist.m3u"
    fi

    popd > /dev/null
done


