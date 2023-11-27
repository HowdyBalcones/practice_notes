# addressPhoneNum.awk -- make addresses into a formatted output
# Fields - Person, Company, Street, City, State & Zip, phone

BEGIN { FS = "\n"; RS="" } #

{
	print $1 ", " $6
}

END { 
	print ""
	print NR, "records processed." 	}


