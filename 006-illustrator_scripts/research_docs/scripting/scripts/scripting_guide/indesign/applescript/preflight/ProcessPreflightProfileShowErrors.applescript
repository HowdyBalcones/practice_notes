--ProcessPreflightProfileShowErrors.applescript
--An InDesign AppleScript
--
--Shows how to process a preflight profile and show errors in a message box.

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
		--Assume there is an document.
		set myDoc to document 1
		--Use the second preflight profile
		set myProfile to preflight profile 2
		
		--Process the doc with the profile
		set myProcess to make preflight process with properties {target object:myDoc, applied profile:myProfile}
		wait for process myProcess
		set results to process results of myProcess
		
		--![Process preflight profile show errors.]
		--If errors were found
		if results is not "None" then
			--array containing detailed results
			tell aggregated results of myProcess
				set str to "Document: " & item 1 & ", Profile: " & item 2 & ", Results: ["
				set errorResults to item 3
			end tell
			--Show the errors in a message box.
			repeat with i from 1 to count of errorResults
				if i > 1 then
					str = str & ", "
				end if
				set str to str & item 2 of item i of errorResults
			end repeat
			set str to str & "]"
			display alert str
		end if
		--![Process preflight profile show errors.]
		
		--Cleanup
		delete myProcess
	end tell
end mySnippet

on myTeardown()
end myTeardown

