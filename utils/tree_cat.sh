#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <directorio>"
    exit 1
fi

dir=$1

echo "Directory: $dir"
tree "$dir"
for file in $(find "$dir" -maxdepth 1 -type f); do
    echo "File: $file"
    cat "$file"
done

