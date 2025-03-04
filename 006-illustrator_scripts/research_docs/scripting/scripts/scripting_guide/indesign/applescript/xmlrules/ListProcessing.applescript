--ListProcessing.applescript
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
	--![List processing.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myRootXML to first XML element of myDocument
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		set myRuleSet to {my ListItems()}
	end tell
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![List processing.]
end mySnippet
on myTeardown()
end myTeardown
--![List processing - functions.]
on ListItems()
	script ListItems
		property name : "ListItems"
		property xpath : "/xmlElement/item[1]/following-sibling::*"
		on apply(myXMLElement, myRuleProcessor)
			tell application "Adobe InDesign 2024"
				tell myXMLElement
					insert text as content using ", " position before element
				end tell
			end tell
			return false
		end apply
	end script
end ListItems
--![List processing - functions.]
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
