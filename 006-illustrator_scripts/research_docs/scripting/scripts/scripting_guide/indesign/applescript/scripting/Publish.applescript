--Publish.applescript
--An InDesign AppleScript
--
--Shows how to generate an earlier version of the AppleScript dictionary.
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
		--<fragment>
		--publish the InDesign CS3 dictionary (version 5.0 DOM)
		publish terminology version 5.0
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
