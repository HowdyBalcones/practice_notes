--BleedSlugGuideColors.applescript
--An InDesign AppleScript
--
--Shows how to set the colors used to display the bleed and slug guides.
--Assumes that you have a document open.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Bleed slug guide colors.]
		--Given an open document...
		tell pasteboard preferences of document 1
			--Any of InDesign's guides can use the UIColors constants...
			set bleed guide color to cute teal
			set slug guide color to charcoal
			--...or you can specify a list of RGB values (with values from 0 to 255)
			set bleed guide color to {0, 198, 192}
			set slug guide color to {192, 192, 192}
		end tell
		--![Bleed slug guide colors.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
