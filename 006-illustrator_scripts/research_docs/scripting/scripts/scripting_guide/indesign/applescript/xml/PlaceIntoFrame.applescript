--PlaceIntoFrame.applescript
--An InDesign AppleScript
--
--Create a frame and place XML within it.
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
			tell view preferences
				set horizontal measurement units to points
				set vertical measurement units to points
			end tell
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
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		--![Place into frame.]
		--Given a document "myDocument"...
		--place into frame has two parameters:
		--on: The page, spread, or master spread on which to create the frame
		--geometric bounds: The bounds of the new frame (in page coordinates).
		tell XML element 1 of myDocument
			place into frame on myPage geometric bounds {72, 72, 288, 288}
		end tell
		--![Place into frame.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
