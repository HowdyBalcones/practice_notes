--PlaceSound.jsx
--An InDesign JavaScript
--
--Shows how to import a sound file.
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
		--![Place sound.]
		--Given a page "myPage" in a document "myDocument..." 
		--Import a sound file (you'll have to provide a valid file path on your system)
		tell myPage
			set mySound to place file "hazuki:sound.mp3" place point {72, 72}
		end tell
		set mySound to item 1 of mySound
		tell mySound
			set embed in PDF to true
			set do not print poster to true
			set sound loop to true
			set stop on page turn to true
		end tell
		--Add a preview image. You'll have to provide a valid path on your system.
		set poster file of mySound to "hazuki:sound poster.jpg"
		--![Place sound.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
