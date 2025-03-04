--MarkingUpGraphics.applescript
--An InDesign AppleScript
--
--Shows how to associate a graphic with an XML element.
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
			set myPage to page 1
			tell myPage
				--You'll have to fill in your own file path.
				place "yukino:test.tif"
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Marking up graphics.]
		tell myDocument
			set myMarkupTag to make XML tag with properties {name:"graphic"}
			tell XML element 1
				set myXMLElement to make XML element with properties {markup tag:myMarkupTag}
			end tell
			set myFrame to rectangle 1 of page 1
			tell myFrame to markup using myXMLElement
		end tell
		--![Marking up graphics.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
