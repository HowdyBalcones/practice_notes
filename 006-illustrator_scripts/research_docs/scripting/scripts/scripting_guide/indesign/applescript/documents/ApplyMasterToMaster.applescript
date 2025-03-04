--ApplyMaster.applescript
--An InDesign AppleScript
--
--Applies a master page to a master page.
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
		set myDocument to document 1
		--![Apply master to master.]
		--Given a document "myDocument"...
		tell myDocument
			set myMasterSpread to master spread 1
			--Create a new master spread.
			set myNewMasterSpread to make master spread
			--Apply the first (default) master spread to the first page of the new master spread.
			set myMasterPage to page 1 of myNewMasterSpread
			set applied master of myMasterPage to myMasterSpread
		end tell
		--![Apply master to master.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
