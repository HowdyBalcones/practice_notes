--PlaceXML.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Places an XML element in a story.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		tell myDocument
			set myRootXMLElement to XML element 1
			set myXMLTag to make XML tag with properties {name:"xml_element"}
		end tell
		tell myRootXMLElement
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"This is a paragraph in an XML story."}
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"This is another paragraph in an XML story."}
			set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"This is the third paragraph in an XML story."}
			set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"This is the last paragraph in an XML story."}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		tell story 1 of myDocument
			place XML using XML element 1 of myDocument
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
