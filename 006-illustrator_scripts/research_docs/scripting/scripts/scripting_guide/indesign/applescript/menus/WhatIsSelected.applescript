--WhatIsSelected.applescript
--An InDesign AppleScript
--
--Provides a "onInvoke" event handler for the BeforeDisplay.applescript
--When invoked, display a message about the selection.
tell application "Adobe InDesign 2024"
	--![What is selected.]
	set mySelection to selection
	if (count mySelection) > 0 then
		set myString to class of item 1 of mySelection as string
		display dialog ("The first item in the selection is a " & myString & ".")
	else
		display dialog ("Nothing is selected.")
	end if
	--![What is selected.]
end tell

