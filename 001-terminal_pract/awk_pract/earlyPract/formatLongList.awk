# formatLongList.awk -- this is a script meant to format the long list output from ls
#

ls -l $*| awk '

BEGIN { printf ("%-25s\t%10s\n", "BYTES", "FILE") }

NF == 9 && /^-/ {
	sum += $5
        ++filenum
	printf("%-25s\t%10d\n", $9, $5)
}

NF == 9 && /^d/ {
	print "<dir>", "\t", $9 # print dir and name 
}

$1 ~ /^\..*:$/ {
	print "\t" $0 
}


END { printf("Total: %d bytes (%d files)\n", sum, filenum) }
'



