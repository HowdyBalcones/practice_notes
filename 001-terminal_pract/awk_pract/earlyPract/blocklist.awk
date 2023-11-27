# blocklist.awk -- print name and address in block form
# fields: name, company, street, city, state and zip, phone

{ print $2, $1, $3 }
{ print $3, $2, $1 }
{ print "\n" }
