--DuplicateXMLElement.applescript
--An InDesign AppleScript
--
--Duplicates an XML element in the XML hierarchy.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set myXMLTag to make XML tag with properties {name:"myXMLTag"}
			set myRootElement to XML element 1
		end tell
		tell myRootElement
			set myXMLElementA to make XML element with properties {markup tag:myXMLTag}
			set contents of myXMLElementA to "This is XML element A."
			set myXMLElementB to make XML element with properties {markup tag:myXMLTag}
			set contents of myXMLElementB to "This is XML element B."
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Duplicate XML element.]
		tell myDocument
			set myRootElement to XML element 1
			set myXMLElementA to XML element 1 of XML element 1
			--<fragment>
			--Given an XML element "myXMLElementA"
			duplicate myXMLElementA
			--</fragment>
			--Place the root XML element so that you can see the result.
			tell story 1
				place XML using myRootElement
			end tell
		end tell
		--![Duplicate XML element.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to left
				set myX1 to right
			else
				set myX1 to left
				set myX2 to right
			end if
			set myY1 to top
			set myY2 to bottom
		end tell
		set myX2 to myPageWidth - myX2
		set myY2 to myPageHeight - myY2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
