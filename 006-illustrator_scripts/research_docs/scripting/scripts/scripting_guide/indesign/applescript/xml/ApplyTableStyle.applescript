--ApplyTableStyle.applescript
--An InDesign AppleScript
--
--Shows how to apply table styles to XML elements.
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
			--Create a series of XML tags.
			set myRowTag to make XML tag with properties {name:"Row"}
			set myCellTag to make XML tag with properties {name:"Cell"}
			set myTableTag to make XML tag with properties {name:"Table"}
			--Create a table style and a cell style.
			set myTableStyle to make table style with properties {name:"myTableStyle", start row fill color:color "Black", start row fill tint:25, end row fill color:color "Black", end row fill tint:10}
			set myCellStyle to make cell style with properties {name:"myCellStyle", fill color:color "Black", fill tint:45}
			--Add XML elements.
			set myRootXMLElement to XML element 1
			tell myRootXMLElement
				set myTableXMLElement to make XML element with properties {markup tag:myTableTag}
				tell myTableXMLElement
					repeat with myRowCounter from 1 to 6
						set myXMLRow to make XML element with properties {markup tag:myRowTag}
						tell myXMLRow
							set myString to "Row " & myRowCounter
							repeat with myCellCounter from 1 to 4
								make XML element with properties {markup tag:myCellTag, contents:myString & ":Cell " & myCellCounter}
							end repeat
						end tell
					end repeat
					set myTable to convert element to table row tag myRowTag cell tag myCellTag
				end tell
			end tell
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
		--![Apply table style.]
		tell myDocument
			set myCellStyle to cell style "myCellStyle"
			set myTableStyle to table style "myTableStyle"
			set myTableXMLElement to XML element 1 of XML element 1
			tell myTableXMLElement
				apply table style using myTableStyle with clearing overrides
				tell XML element 1 to apply cell style using myCellStyle
				tell XML element 4 to apply cell style using myCellStyle
				tell XML element 9 to apply cell style using myCellStyle
				tell XML element 14 to apply cell style using myCellStyle
				tell XML element 15 to apply cell style using myCellStyle
				tell XML element 20 to apply cell style using myCellStyle
			end tell
		end tell
		--Place the story so that you can see the result of the change.
		tell story 1 of myDocument
			place XML using XML element 1 of myDocument
		end tell
	end tell
	--![Apply table style.]
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
