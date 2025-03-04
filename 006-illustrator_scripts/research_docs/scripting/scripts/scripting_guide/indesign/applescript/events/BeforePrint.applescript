--BeforePrint.applescript
--An InDesign Applescript
--
--Adds an event listener that performs a preflight check on
--a document before printing. If the preflight check fails, 
--the script gives the user the opportunity to cancel the print job.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Before print.]
	tell application "Adobe InDesign 2024"
		make event listener with properties {event type:"beforePrint", handler:"yukino:IDEventHandlers:BeforePrintHandler.applescript"}
	end tell
	--![Before print.]
end mySnippet
on myTeardown()
end myTeardown

