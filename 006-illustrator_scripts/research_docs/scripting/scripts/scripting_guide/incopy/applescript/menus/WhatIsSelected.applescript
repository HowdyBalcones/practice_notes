--WhatIsSelected.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Works with the BeforeDisplay tutorial script to
--display a message about the selection.
tell application "Adobe InCopy 2024"
	set mySelection to selection
	if (count mySelection) > 0 then
		set myString to class of item 1 of mySelection as string
		display dialog ("The first item in the selection is a " & myString & ".")
	end if
end tell
