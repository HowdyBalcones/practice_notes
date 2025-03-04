--ProcessPreflightProfile.applescript
--An InDesign AppleScript
--
--Shows how to process an InDesign preflight profile.

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
		--![Process preflight profile.]
		--Assume there is an document.
		set myDoc to document 1
		--Use the second preflight profile
		set myProfile to preflight profile 2
		
		--Process the doc with the profile
		set myProcess to make preflight process with properties {target object:myDoc, applied profile:myProfile}
		wait for process myProcess
		set results to process results of myProcess
		
		-- If errors were found
		if results is not "None" then
			-- Export the file to PDF, and to open the file after export.
			save report myProcess to "Macintosh HD:tmp:PreflightResults.pdf" with auto open
		end if
		
		--Cleanup
		delete myProcess
		--![Process preflight profile.]
	end tell
end mySnippet

on myTeardown()
end myTeardown

