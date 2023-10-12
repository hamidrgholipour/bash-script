#!/bin/bash


search_string=""
replace_string="new"
input_file="doc"
output_file="out_doc"


sed "s/$search_string/$replace_string/g" "$input_file" > "$output_file"

echo "Replacement completed -> $output_file."
