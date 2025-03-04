--RemoveArticle.applescript
--An InDesign AppleScript
--
--Shows how to remove articles.
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
			make article with properties {name:"Article1", article export status:true}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Remove article.]
		set myDocument to document 1
		tell article 1 of myDocument to delete
		--![Remove article.]
	end tell
end mySnippet
on myTeardown()
end myTeardown