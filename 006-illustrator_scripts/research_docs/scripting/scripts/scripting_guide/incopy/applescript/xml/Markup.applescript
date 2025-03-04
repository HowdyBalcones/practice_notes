--Markup.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to associate an existing text object with an XML element.
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
			--Place the XML root element so that you can see the result in the Structure panel.
			tell story 1
				place XML using myRootXMLElement
				set myString to "This is the first paragraph in the story." & return
				set myString to myString & "This is the second paragraph in the story." & return
				set myString to myString & "This is the third paragraph in the story." & return
				set myString to myString & "This is the fourth paragraph in the story." & return
				set contents to myString
			end tell
			tell myRootXMLElement
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
			end tell
			tell paragraph 3 of story 1
				markup using myXMLElement
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown


