--ImportXMLIntoSelectedElement.applescript
--An InDesign AppleScript
--
--Imports an XML file into the selected XML element.
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
			set myRootElement to XML element 1
			set myXMLTag to make XML tag with properties {name:"xml_element"}
			tell myRootElement
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
			end tell
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		tell myDocument
			--![Import XML into selected element.]
			tell XML import preferences
				set import to selected to true
			end tell
			set myRootElement to XML element 1
			set myXMLElement to XML element 1 of myRootElement
			select myXMLElement
			--You'll have to fill in your own file path.
			import XML from "yukino:test.xml"
			--![Import XML into selected element.]
			--Place the XML element so that you can see the result.
			tell story 1
				place XML using myXMLElement
			end tell
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
