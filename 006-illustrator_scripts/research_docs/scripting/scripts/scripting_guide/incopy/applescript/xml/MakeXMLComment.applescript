--MakeXMLComment.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Adds an XML comment.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		tell myDocument
			set myXMLTag to make XML tag with properties {name:"myXMLElement"}
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
				tell myXMLElement
					make XML comment with properties {value:"This is an XML comment."}
				end tell
			end tell
			tell story 1
				place XML using myXMLElement
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
