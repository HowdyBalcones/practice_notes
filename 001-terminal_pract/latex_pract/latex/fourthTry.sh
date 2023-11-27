#!/bin/bash
# fourthTry.sh -- send prodLog to latex template

prodS2 ; formatTexBasic > report.txt 


processed_content=$(awk '{printf "%s\\n", $0}' report.txt | sed 's/#//g'  ) 

# the below takes preprocessed content and places it into the template for this latex report, takes the filled template and copies it to the report.tex for processing by Xelatex

awk -v content="$processed_content" '{gsub(/%PULLME/, content); print
} ' fourthTryTemplate.tex > report.tex

# there are a number of problems at this point, mainly trying to
# alter the tex ready template for processing by the tex compiler
# the below attempts to solve the issue by printing the desired 
# records based on matches at the start of each record. The problem
# is that instead of changing the tex template we are outputting to 
# above, we have to change the below statement. 

# literally -- below prints the content from report.tex, does formatting, 
# outputs to reportF.tex

awk ' BEGIN {FS="\t"}
{if ($0 ~ /^\\/) {print "\n"$0"\n"}
if ($1 ~ /ItemNum/ || /^Dispenser/ || /^Each/ || /^Sleeve/ || /^Case/) {print $1"\\hspace{2cm}",$2,"\\\\"}
if ($0 ~ /^Description/) {print "\{\\bfseries", $0, "\}" "\\\\"} 
	#bfseries bolds between the brackets
if ($1 ~ /^Case/) {print "\n"}}	# makes newline after case record
' report.tex > reportF.tex

cat reportF.tex


xelatex reportF.tex
#rm reportF.*
