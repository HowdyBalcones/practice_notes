--AddReturnsAndStaticText.applescript
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
	--![Add returns and static text.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myRootXML to first XML element of myDocument
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		set myRuleSet to {my ProcessDevice(), my ProcessName(), my ProcessType(), my ProcessPartNumber(), my ProcessSupplyVoltage(), my ProcessPackageType(), my ProcessPackageOne(), my ProcessPackages(), my ProcessPrice()}
	end tell
	tell myGlueCode
		--The third parameter of __processRuleSet is a
		--prefix mapping table; we'll leave it empty.
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Add returns and static text.]
end mySnippet
on myTeardown()
end myTeardown
--![Add returns and static text - functions.]
on ProcessDevice()
	script ProcessDevice
		property name : "ProcessDevice"
		property xpath : "/devices/device"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using return position after element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessDevice
on ProcessName()
	script ProcessName
		property name : "ProcessName"
		property xpath : "/devices/device/name"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using "Device Name: " position before element
						insert text as content using return position after element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessName
to ProcessType()
	script ProcessType
		property name : "ProcessType"
		property xpath : "/devices/device/type"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using "Circuit Type: " position before element
						insert text as content using return position after element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessType
to ProcessPartNumber()
	script ProcessPartNumber
		property name : "ProcessPartNumber"
		property xpath : "/devices/device/part_number"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using "Part Number: " position before element
						insert text as content using return position after element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessPartNumber
to ProcessSupplyVoltage()
	script ProcessSupplyVoltage
		property name : "ProcessSupplyVoltage"
		property xpath : "/devices/device/supply_voltage"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using "Supply Voltage: From: " position before element
						insert text as content using return position after element
						tell XML element 1
							insert text as content using " to " position after element
						end tell
						tell XML element -1
							insert text as content using " volts" position after element
						end tell
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessSupplyVoltage
--
to ProcessPackageType()
	script ProcessPackageType
		property name : "ProcessPackageType"
		property xpath : "/devices/device/package/type"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using "-" position after element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessPackageType
--Add the text "Package:" before the list of packages.
to ProcessPackageOne()
	script ProcessPackageOne
		property name : "ProcessPackageOne"
		property xpath : "/devices/device/package[1]"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using "Package: " position before element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessPackageOne
--Add commas between the package types and a return at the end of the packages.
to ProcessPackages()
	script ProcessPackages
		property name : "ProcessPackages"
		property xpath : "/devices/device/package"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						set myIndex to index of myXMLElement
						if myIndex is not 1 then
							insert text as content using ", " position before element
						end if
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessPackages
--
to ProcessPrice()
	script ProcessPrice
		property name : "ProcessPrice"
		property xpath : "/devices/device/price"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using return position before element
						insert text as content using "Price: $" position before element
						insert text as content using return position after element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessPrice
--![Add returns and static text - functions.]
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
