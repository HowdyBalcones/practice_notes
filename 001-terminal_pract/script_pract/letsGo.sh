#!/bin/bash

while IFS= read -r item; do
	mkdir "$item"
done < list-data.txt
