--SimpleDialog.applescript
--An InDesign AppleScript
--
--Creates a very simple InDesign script dialog box.
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
		--![Simple dialog.]
		set myDialog to make dialog with properties {name:"Simple Dialog"}
		tell myDialog
			tell (make dialog column)
				make static text with properties {static label:"This is a very simple dialog box."}
			end tell
		end tell
		--Show the dialog box.
		set myResult to show myDialog
		--If the user clicked OK, display one message;
		--if they clicked Cancel, display a different message.
		if myResult is true then
			display dialog ("You clicked the OK button")
		else
			display dialog ("You clicked the Cancel button")
		end if
		--Remove the dialog box from memory.
		destroy myDialog
		--![Simple dialog.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
