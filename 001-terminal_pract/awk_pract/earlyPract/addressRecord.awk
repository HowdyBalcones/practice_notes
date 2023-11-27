# addressRecord.awk -- use the record separator builtin
# The advantage of this setup is that you can take blocks of text and sort them into fields, rows, as you will. 

BEGIN { FS = "\n"; RS= "" }
{ print $1, $NF }
