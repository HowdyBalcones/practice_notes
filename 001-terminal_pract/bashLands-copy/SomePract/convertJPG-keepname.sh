#!/bin/bash

eps_directory="."

for file in "$eps_directory"/*.eps; do
	base_name="${file%.*}"
	convert -density 400 "$file" "$base_name.jpg"
done

