--ReorderArticles.applescript
--An InDesign AppleScript
--
--Shows how to reorder articles.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Reorder articles.]
		tell myDocument
			set article1 to make article with properties {name:"Article1"}
			set article2 to make article with properties {name:"Article2"}
			set article3 to make article with properties {name:"Article3"}
			set article4 to make article with properties {name:"Article4"}
			
			move article4 to beginning of article 0
			move article1 to end of article 0
			move article3 to after article4
			move article2 to before article1
		end tell
		--![Reorder articles.]
	end tell
end mySnippet
on myTeardown()
end myTeardown