--FindXMLElementByFindText.applescript
--An InDesign AppleScript
--
--Finds an XML element using find text.
global myGlueCode
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set mySetupScriptFile to my myFindFile("XMLRuleExampleSetup.appleScript", "Locate the file XMLRuleExampleSetup.appleScript")
		do script mySetupScriptFile
	end tell
end mySetup
on mySnippet()
	--![Find XML element by find text.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myPage to active page of active window
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		tell document 1
			set myRootXML to first XML element
			set myColorA to make color with properties {name:"ColorA", model:process, color value:{0, 100, 80, 0}}
		end tell
	end tell
	set myGlueCode to load script file myFilePath
	set myRuleSet to {my FindByFindText()}
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Find XML element by find text.]
end mySnippet
on myTeardown()
end myTeardown
--![Find XML element by find text - functions.]
on FindByFindText()
	script FindByFindText
		property name : "FindByFindText"
		property xpath : "/devices/device/description"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set find text preferences to nothing
				set change text preferences to nothing
				set find what of find text preferences to "triangle"
				try
					tell myXMLElement
						set myFoundItems to find text
						if (count myFoundItems) is greater than 0 then
							set fill color of text 1 to "ColorA"
						end if
					end tell
				on error myError
					set myReturnString to myError
				end try
				set find text preferences to nothing
				set change text preferences to nothing
			end tell
			return false
		end apply
	end script
end FindByFindText
--![Find XML element by find text - functions.]
on myFindFile(myFindFileName, myString)
	tell application "Adobe InDesign 2024"
		try
			set myScript to active script
		on error
			set myScript to path to me
		end try
	end tell
	tell application "Finder"
		set myScript to file myScript
		set myParentFolder to (container of myScript) as string
		set myFileName to myParentFolder & myFindFileName
		set myResult to exists myFileName
		if myResult is true then
		else
			set myFileName to choose file with prompt myString
		end if
	end tell
	return myFileName
end myFindFile
