cat prodLog.txt | awk 'BEGIN { FS=","}{OFS="\n" } 
 
/^[A-Za-z]./ && $1 !~ DESCRIPTION	{ printf ("Description: \t%s\nItem_#:\t\t%s\nEach_UPC:\t%s\nSleeve_UPC:\t%s\nCase_UPC:\t%s\n\n", $1, $2, $3, $4, $5)

	}
'
