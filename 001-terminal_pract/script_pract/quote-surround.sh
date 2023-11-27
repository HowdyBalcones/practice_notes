#!/bin/bash

input_file="list-data.txt"
output_file="formatted-list.txt"

sed 's/^/"/; s/$/"/' "$input_file" > "$output_file"

