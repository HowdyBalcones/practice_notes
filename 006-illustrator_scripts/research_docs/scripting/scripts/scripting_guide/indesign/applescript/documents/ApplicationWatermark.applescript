--ApplicationWatermark.applescript
--An InDesign AppleScript
--
--Shows how to set the properties of the watermark feature.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Application watermark.]
		tell watermark preferences
			set watermark visibility to true
			set watermark do print to true
			set watermark draw in back to true
			set watermark text to "Confidential"
			set watermark font family to "Arial"
			set watermark font style to "Bold"
			set watermark font point size to 72
			set watermark font color to red
			set watermark opacity to 60
			set watermark rotation to -45
			set watermark horizontal position to watermark h center
			set watermark horizontal offset to 0
			set watermark vertical position to watermark v center
			set watermark vertical offset to 0
		end tell
		--![Application watermark.]
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		tell document preferences of myDocument
			set page height to 792
			set page width to 612
		end tell
		tell master spread 1 of myDocument
			tell margin preferences of pages
				set top to 36
				set bottom to 36
				set left to 36
				set right to 36
			end tell
		end tell
		tell page 1 of myDocument
			set myTextFrame to make text frame with properties {geometric bounds:{36, 36, 756, 576}, contents:placeholder text}
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown








