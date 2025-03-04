--HelloWorldUI.astell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to create a simple dialog box and use the
--dialog box settings in a script.
tell application "Adobe InCopy 2024"
	activate
	set myDocument to make document
	set myDialog to make dialog
	tell myDialog
		set name to "Simple User Interface Example Script"
		set myDialogColumn to make dialog column
		tell myDialogColumn
			--Create a text entry field.
			set myTextEditField to make text editbox with properties {edit contents:"Hello World!", min width:180}
			--Create a number (real) entry field.
			set myPointSizeField to make real editbox with properties {edit contents:"72"}
		end tell
		show
		--Get the settings from the dialog box.
		--Get the point size from the point size field.
		set myPointSize to edit contents of myPointSizeField as real
		--Get the example text from the text edit field.
		set myString to edit contents of myTextEditField
		--Remove the dialog box from memory.
		destroy myDialog
	end tell
	tell story 1 of myDocument
		--Apply the settings from the dialog box to the text frame.
		set contents to myString
		--Set the point size of the text in the story.
		set point size of text 1 to myPointSize
	end tell
end tell
