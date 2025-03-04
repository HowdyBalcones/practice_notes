--CustomLabel.applescript
--An InDesign AppleScript
--
--Shows how to add and extract custom labels 
--to page items.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		tell page 1 of myDocument
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 144}}
		end tell
	end tell
end mySetup
on mySnippet()
	--![Working with Custom Label.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		set myRectangle to rectangle 1 of myPage
		tell myPage
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 144}}
			--Insert a custom label using insert label. The first parameter is the
			--name of the label, the second is the text to add to the label.
			tell myRectangle
				insert label key "CustomLabel" value "This is some text stored in a custom label."
				--Extract the text from the label and display it in an alert.
				set myString to extract label key "CustomLabel"
			end tell
			display dialog ("Custom label contained: " & myString)
		end tell
	end tell
	--![Working with Custom Label.]
end mySnippet
on myTeardown()
end myTeardown
