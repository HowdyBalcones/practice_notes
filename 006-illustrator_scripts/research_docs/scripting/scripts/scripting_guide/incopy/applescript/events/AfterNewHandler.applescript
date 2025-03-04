--AfterNewHandler.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--This even handler adds XMP information to a document
--after it is created.
--<fragment>
main(evt)
on main(myEvent)
	tell application "Adobe InCopy 2024"
		set user name to "Adobe"
		set myDocument to document 1
		tell metadata preferences of myDocument
			set author to "Adobe Systems"
			set description to "This is an example document containing XMP metadata. Created: " & time stamp of myEvent
		end tell
	end tell
end main
--</fragment>
