--XMLRulesProcessor.applescript
--An InDesign AppleScript
--
--Uses the XML rule processor object to find XML elements
--in the XML structure of a document using XPath.
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
	--![XML rules processor.]
	set myXPath to {"/devices/device"}
	set myXMLMatches to mySimulateXPath(myXPath)
	--At this point, myXMLMatches contains all of the XML elements
	--that matched the XPath expression provided in myXPath.
	--In a real script, you could now process the elements.
	--For this example, however, we'll simply display a message.
	display dialog ("Found " & (count myXMLMatches) & " matching XML elements.")
	--![XML rules processor.]
end mySnippet
on myTeardown()
end myTeardown
--![XML rules processor - functions.]
on mySimulateXPath(myXPath)
	set myMatchingElements to {}
	tell application "Adobe InDesign 2024"
		set myRuleProcessor to make XML rule processor with properties {rule paths:myXPath}
		set myDocument to document 1
		set myRootXMLElement to XML element 1 of myDocument
		tell myRuleProcessor
			set myMatchData to start processing rule set initial element myRootXMLElement
			repeat until myMatchData is nothing
				local myMatchData
				local myMatchingElements
				set myXMLElement to item 1 of myMatchData
				set myMatchingElements to myMatchingElements & myXMLElement
				set myMatchData to find next match
			end repeat
		end tell
		return myMatchingElements
	end tell
end mySimulateXPath
--![XML rules processor - functions.]
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
