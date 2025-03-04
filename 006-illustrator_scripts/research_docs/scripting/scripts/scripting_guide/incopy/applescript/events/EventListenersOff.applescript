--RemoveEventListeners.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Removes all application and document event listeners.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--<fragment>
	tell application "Adobe InCopy 2024"
		tell event listeners to delete
		repeat with myDocument in documents
			tell event listeners of myDocument to delete
		end repeat
	end tell
	--</fragment>
end mySnippet
on myTeardown()
end myTeardown

