--SimpleDialog.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Creates a very simple InCopy script dialog box.
tell application "Adobe InCopy 2024"
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
end tell
