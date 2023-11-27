# addressBlockList.awk -- make addresses into a formatted output
# Fields - Person, Company, Street, City, State & Zip, phone

BEGIN { FS = ", *" } #comma separated fields

{
	print ""	# blank line
	print $1	# name
	print $2	# company
	print $3	# street
	print $4, $5	# city, state zip

}

END { 
	print ""
	print NR, "records processed." 	}
