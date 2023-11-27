# checkGrades.awk -- averages grades in the given format

BEGIN {
	OFS="\n"

}


{
#	total = $2 + $3 + $4 + $5 + $6
#	avg = total / 5

	total = 0
	for (i = 2; i <= NF; i++)
		total += $i
	avg = total / (NF -1)

# 	the above counts the number of fields for each record and performs 
# 	an averaging algorithm to each

	if (avg >= 90) grade = "A"
	else if (avg >= 80) grade = "B"
	else if (avg >= 70) grade = "C"
	else if (avg >= 60) grade = "D"
	else grade = "F"

	print NR ".", $1, avg, grade, ""
	
}


