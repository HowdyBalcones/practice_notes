--XMLRulesApplyFormatting.applescript
--An InDesign AppleScript
--
--Shows how XML rules can be used to apply text formatting.
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
	--![XML rules apply formatting.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		tell myDocument
			tell view preferences
				set horizontal measurement units to points
				set vertical measurement units to points
				set ruler origin to page origin
			end tell
			set myRootXML to first XML element
			set myColor to make color with properties {model:process, color value:{0, 100, 100, 0}, name:"Red"}
			make paragraph style with properties {name:"DeviceName", point size:24, leading:24, space before:24, fill color:"Red", rule above:true, rule above offset:24}
			make paragraph style with properties {name:"DeviceType", point size:12, font style:"Bold", leading:12}
			make paragraph style with properties {name:"PartNumber", point size:12, font style:"Bold", leading:12}
			make paragraph style with properties {name:"Voltage", point size:10, leading:12}
			make paragraph style with properties {name:"DevicePackage", pointSize:10, leading:12}
			make paragraph style with properties {name:"Price", point size:10, leading:12, font style:"Bold", space after:12}
		end tell
	end tell
	set myGlueCode to load script file myFilePath
	set myRuleSet to {my ProcessDevice(), my ProcessName(), my ProcessType(), my ProcessPartNumber(), my ProcessSupplyVoltage(), my ProcessPackageType(), my ProcessPrice(), my ProcessPackageOne(), my ProcessPackages()}
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![XML rules apply formatting.]
end mySnippet
on myTeardown()
end myTeardown
--![XML rules apply formatting - functions.]
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
						insert text as content using return position after element
						apply paragraph style using "DeviceName"
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessName
on ProcessType()
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
						apply paragraph style using "DeviceType"
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessType
on ProcessPartNumber()
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
						apply paragraph style using "PartNumber"
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
						tell XML element 1
							insert text as content using " to " position after element
						end tell
						tell XML element -1
							insert text as content using " volts" position after element
						end tell
						insert text as content using return position after element
						apply paragraph style using "Voltage"
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessSupplyVoltage
on ProcessPackageType()
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
on ProcessPackageOne()
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
						apply paragraph style using "DevicePackage"
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
on ProcessPackages()
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
on ProcessPrice()
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
						apply paragraph style using "Price"
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessPrice
--![XML rules apply formatting - functions.]
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
