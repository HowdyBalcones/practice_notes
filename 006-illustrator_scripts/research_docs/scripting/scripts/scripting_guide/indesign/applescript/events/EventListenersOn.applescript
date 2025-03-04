--EventListenersOn.applescript
--An InDesign AppleScript
--
--Turns on a selection of event listeners on the application object.
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
		--![Event listeners on.]
		set myEventNames to {"beforeNew", "afterNew", "beforeQuit", "afterQuit", "beforeOpen", "afterOpen", "beforeClose", "afterClose", "beforeSave", "afterSave", "beforeSaveAs", "afterSaveAs", "beforeSaveACopy", "afterSaveACopy", "beforeRevert", "afterRevert", "beforePrint", "afterPrint", "beforeExport", "afterExport", "beforeImport", "afterImport", "beforePlace", "afterPlace"}
		repeat with myEventName in myEventNames
			make event listener with properties {event type:myEventName, handler:"yukino:scripts:GetEventInfo.applescript"}
		end repeat
		--![Event listeners on.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
