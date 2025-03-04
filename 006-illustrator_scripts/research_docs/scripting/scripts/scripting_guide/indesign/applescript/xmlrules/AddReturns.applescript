--AddReturns.applescript
--An InDesign AppleScript
--
--Defines a simple XML rule.
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
	--![Add returns.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myRootXML to first XML element of myDocument
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		set myRuleSet to {my AddReturns()}
	end tell
	tell myGlueCode
		--The third parameter of __processRuleSet is a
		--prefix mapping table; we'll leave it empty.
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Add returns.]
end mySnippet
on myTeardown()
end myTeardown
--![Add returns - functions.]
on AddReturns()
	script AddReturns
		property name : "AddReturns"
		property xpath : "//*"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using return position element end
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return false
		end apply
	end script
end AddReturns
--![Add returns - functions.]
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
