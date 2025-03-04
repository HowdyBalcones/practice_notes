--DuplicateXMLElement.applescript
--An InDesign AppleScript
--
--Duplicates an XML element in the XML structure.
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
	--![Duplicate XML element rule.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myRootXML to first XML element of myDocument
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		set myRuleSet to {my DuplicateElement()}
	end tell
	tell myGlueCode
		--The third parameter of __processRuleSet is a
		--prefix mapping table; we'll leave it empty.
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Duplicate XML element rule.]
end mySnippet
on myTeardown()
end myTeardown
--![Duplicate XML element rule - functions.]
to DuplicateElement()
	script DuplicateElement
		property name : "DuplicateElement"
		property xpath : "/devices/device/part_number"
		on apply(myXMLElement, myRuleProcessor)
			--Because this rule makes changes to the XML structure,
			--you must use __skipChildren to avoid invalidating
			--the XML object references.
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						duplicate
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end DuplicateElement
--![Duplicate XML element rule - functions.]
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
