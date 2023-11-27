/^$/ {
	print "Line:", FNR,"\t" ,"Blank:", ++x
	
}


END { print "Total Blank Lines: ", x, "of" ,NR, "Lines" }


