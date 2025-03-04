--ConvertElementToAttribute.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to convert an XML element into an XML attribute.
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
		end tell
		tell myRootXMLElement
			set myXMLElement to make XML element with properties {markup tag:myXMLTag, contents:"This is content in an XML element."}
		end tell
		tell myXMLElement
			convert to attribute
		end tell
		--Place the story so that you can see the result of the change.
		tell story 1 of myDocument
			place XML using myRootXMLElement
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown

