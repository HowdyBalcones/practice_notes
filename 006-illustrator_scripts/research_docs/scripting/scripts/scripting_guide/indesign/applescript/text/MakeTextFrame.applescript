--MakeTextFrame.applescript
--An InDesign AppleScript
--
--Create a text frame and place some text in it.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Create a text frame.]
		--Given a document "myDocument"...
		set myDocument to document 1
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame
			--Set the bounds of the text frame.
			set geometric bounds of myTextFrame to {72, 72, 288, 288}
			--Enter text in the text frame.
			set contents of myTextFrame to "This is some example text."
			--Note that you could also use a properties record
			--to set the bounds and contents of the text in a 
			--single line:
			--set myTextFrame to make text frame with properties{geometric bounds:{72, 72, 288, 288}, contents:"This is some example text."}
		end tell
		--![Create a text frame.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
