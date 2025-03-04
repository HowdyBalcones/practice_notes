--Acceptchange.applescript
--An InCopy AppleScript
--
--Get Accept Trackchange.

main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		--<fragment>
		set myDocument to document 1
		tell myDocument
			set myStory to story 1
			tell myStory
				set myChange to change 1
				tell myChange
					accept
				end tell
			end tell
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
