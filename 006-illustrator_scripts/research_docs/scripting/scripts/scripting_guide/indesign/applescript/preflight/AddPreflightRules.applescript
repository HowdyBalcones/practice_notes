--AddPreflightRules.applescript
--An InDesign AppleScript
--
--Shows how to add rules to an InDesign preflight profile.

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
		--Add a new preflight profile.
		set myProfile to make preflight profile
		display alert "Preflight profile " & (name of myProfile) & " is created."
		
		--<fragment>
		--Add a rule that requires a specific page size and orientation 
		--(portrait or landscape).
		set RULE_NAME to "ADBE_PageSizeOrientation"
		set myRule to make preflight profile rule in myProfile with properties {name:RULE_NAME, id:RULE_NAME}
		--</fragment>
		
		--<fragment>
		tell myRule
			--Requires the page size to be 8.5in x 11in (Letter Size)
			--enters a value for tolerance
			make rule data object with properties {name:"tolerance", data type:real data type, data value:0.01}
			--Sets the width  to the point equivalent of 8.5 inches
			make rule data object with properties {name:"width", data type:real data type, data value:612}
			--Sets the width  to the point equivalent of 11 inches
			make rule data object with properties {name:"height", data type:real data type, data value:792}
			--true = ignore orientation is checked
			make rule data object with properties {name:"ignore_orientation", data type:boolean data type, data value:true}
		end tell
		--</fragment>
		
		--<fragment>
		--set the rule to return an error
		set flag of myRule to return as error
		--</fragment>
	end tell
end mySnippet

on myTeardown()
end myTeardown
