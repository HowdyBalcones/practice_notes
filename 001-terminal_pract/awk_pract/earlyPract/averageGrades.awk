# averageGrades.awk -- averages grades in the given format

BEGIN {
	OFS="\n"

}

{
	total = $2 + $3 + $4 + $5 + $6
	avg = total / 5
	print NR ".", $1, avg, ""
	
}
