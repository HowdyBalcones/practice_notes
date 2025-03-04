--CreateAlternateLayout.applescript
--An InDesign AppleScript
--
--Shows how to create alternate layout.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
--<setup>
on mySetup()
end mySetup
--</setup>
--<snippet>
on mySnippet()
	tell application "Adobe InDesign 2024"
		tell documents to close saving no
	end tell
	--![Create alternative layout.]
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell document preferences of myDocument
			set facing pages to false
			set pages per document to 1
			set page width to 1024
			set page height to 768
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set layout rule to object based
			set myItem to make rectangle
			set geometric bounds of myItem to {50, 50, 100, 100}
		end tell
		tell myDocument
				create alternate layout spread items spreads
					name "new layout"
					width page height of document preferences
					height page width of document preferences
					layout rule preserve existing
					with create text styles and link text stories
		end tell
	end tell
	--![Create alternative layout.]
end mySnippet
--</snippet>
--<teardown>
on myTeardown()
end myTeardown
--</teardown>