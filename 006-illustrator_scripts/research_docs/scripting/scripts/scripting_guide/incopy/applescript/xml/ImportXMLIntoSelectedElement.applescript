--ImportXMLIntoSelectedElement.applescript
--An InCopy AppleScript
--
--Imports an XML file into the selected XML element.
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
			set myRootElement to XML element 1
			set myXMLTag to make XML tag with properties {name:"xml_element"}
			tell XML import preferences
				set import to selected to true
			end tell
			tell myRootElement
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
			end tell
			select myXMLElement
			import XML from "Macintosh HD:c:test.xml"
			--Place the root XML element so that you can see the result.
			tell story 1
				place XML using myXMLElement
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
