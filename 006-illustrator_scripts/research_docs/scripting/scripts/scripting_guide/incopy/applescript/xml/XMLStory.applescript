--XMLStory.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to work with XML text data that has not yet been placed.
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
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag, contents:"This is a paragraph in an XML story."}
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag, contents:"This is another paragraph in an XML story."}
			set myXMLElementC to make XML element with properties {markup tag:myXMLTag, contents:"This is the third paragraph in an example XML story."}
			set myXMLElementD to make XML element with properties {markup tag:myXMLTag, contents:"This is the last paragraph in the XML story."}
		end tell
		set myXMLStory to xml story 1 of myDocument
		set the point size of text 1 of myXMLStory to 72
		--Place the story so that you can see the result of the change.
		tell story 1 of myDocument
			place XML using myRootXMLElement
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
