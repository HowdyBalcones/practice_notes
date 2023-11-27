#!/bin/bash

eps_directory="."

for file in "$eps_directory"/*.pdf; do
	base_name="${file%.*}"
	convert -density 200 "$file" "$base_name.bmp"
done

