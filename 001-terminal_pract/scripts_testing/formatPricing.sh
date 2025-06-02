#!/bin/bash
# formatPricing.sh -- make pricing data useable
# name, item#, price, customer type, price Group


sed 's/,//g' | awk ' BEGIN{ FS="\"\""; OFS="\t\t" }
$1 ~ /^"/ {sub(/^"/, "", $1)}
$4 ~ /^0/ {gsub(/^0/, "#0", $4)}
{print $1, $4, $9, $11, $15, $16}
' > formatted.tsv;

cat formatted.tsv | awk ' BEGIN{ FS="\t\t" }
{printf ("%s %s %s %s %s %s\n", $1 "\t", "\t"$2"\t", "\t"$3"\t", "\t"$4"\t", "\t"$5"\t", "\t"$6"\t")}
'


