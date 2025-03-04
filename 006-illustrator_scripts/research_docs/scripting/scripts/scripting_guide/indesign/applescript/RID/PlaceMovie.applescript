--PlaceMovie.applescript
--An InDesign AppleScript
--
--Shows how to import a movie file.
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
			set ruler origin to page origin
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		--![Place movie.]
		--Given a page "myPage"... 
		tell myPage
			set myFrame to make rectangle with properties {geometric bounds:{72, 72, 288, 288}}
		end tell
		--Import a movie file (you'll have to provide a valid file path on your system)
		tell myFrame to place file "hazuki:movie.mp4"
		set myMovie to movie 1 of myFrame
		--Set movie properties.
		set embed in PDF of myMovie to true
		set show controls of myMovie to true
		get properties of myMovie
		--Add a preview image. You'll have to provide a valid path on your system.
		set poster file of myMovie to "hazuki:movie poster.jpg"
		--![Place movie.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
