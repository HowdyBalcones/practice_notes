--LayerControl.applescript
--An InDesign AppleScript
--
--Shows how to work with layer visibility and printing.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	set myList to {"A", "B", "C"}
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			make layer with properties {name:"Background"}
			make layer with properties {name:"Language A"}
			make layer with properties {name:"Language B"}
			make layer with properties {name:"Language C"}
			set myPage to page 1
			set myBounds to my myGetBounds(myDocument, myPage)
			tell page 1
				make rectangle with properties {geometric bounds:myBounds, fill color:color "Black" of myDocument, fill tint:20, item layer:layer "Background" of myDocument}
				set myX1 to (item 2 of myBounds) + ((((item 4 of myBounds) - (item 2 of myBounds)) / 2) - 144)
				set myY1 to (((item 3 of myBounds) - (item 1 of myBounds)) / 2) - 144
				set myX2 to (item 2 of myBounds) + ((((item 4 of myBounds) - (item 2 of myBounds)) / 2) + 144)
				set myY2 to (((item 3 of myBounds) - (item 1 of myBounds)) / 2) + 144
				repeat with myCounter from 1 to 3
					set myLayerName to "Language " & item myCounter of myList
					make text frame with properties {item layer:layer myLayerName of myDocument, contents:myLayerName, geometric bounds:{myY1, myX1, myY2, myX2}}
				end repeat
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		local myPath
		set myDocument to document 1
		--![Control layer.]
		--Given a document "myDocument" containing layers named "Background,"
		--"Language A,", "Language B," and "Language C," export the "Background"
		--layer and each "Language" layer to PDF as separate PDF files...
		set myList to {"A", "B", "C"}
		set myPath to path to desktop as string
		tell myDocument
			repeat with myCounter from 1 to 3
				set myVersion to "Language " & item myCounter of myList
				repeat with myLayerCounter from 1 to (count layers)
					if name of layer myLayerCounter is equal to myVersion or name of layer myLayerCounter is equal to "Background" then
						set visible of layer myLayerCounter to true
						set printable of layer myLayerCounter to true
					else
						set visible of layer myLayerCounter to false
						set printable of layer myLayerCounter to false
					end if
				end repeat
				set myFilePath to myPath & myVersion & ".pdf"
				export to myFilePath format PDF type
			end repeat
		end tell
		--![Control layer.]
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
