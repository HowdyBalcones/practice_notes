--ApplyMaster.applescript
--An InDesign AppleScript
--
--Applies a master spread to a page.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
to mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			try
				set myMasterSpread to master spread "B-Master"
			on error
				set myMasterSpread to make master spread with properties {name:"B-Master"}
			end try
		end tell
	end tell
end mySetup
on mySnippet()
	--Applies a master spread to a page.
	--Assumes that you have document open with a master page named "B-Master"
	--and at least two document pages.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Apply master spread.]
		--Given a document "myDocument"...
		tell myDocument
			set myPage to make page
			set applied master of myPage to master spread "B-Master"
		end tell
		--![Apply master spread.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
