--BeforePrintHandler.applescript
--An InDesign AppleScript
--
--![Before print handler.]
--Provides a "beforePrint" event handler for the BeforePrint.applescript
--tutorial script. Peforms a preflight check on a document. "evt" is the event
--passed to this script by the event listener.
--
myBeforePrintHandler(evt)
on myBeforePrintHandler(myEvent)
	tell application "Adobe InDesign 2024"
		--The parent of the event is the document.
		set myDocument to parent of myEvent
		if my myPreflight(myDocument) is false then
			tell myEvent
				stop propagation
				prevent default
			end tell
			display dialog ("Document did not pass preflight check. Please fix the problems and try again.")
		else
			display dialog ("Document passed preflight check. Ready to print.")
		end if
	end tell
end myBeforePrintHandler
on myPreflight(myDocument)
	set myPreflightCheck to true
	set myFontCheck to my myCheckFonts(myDocument)
	set myGraphicsCheck to my myCheckGraphics(myDocument)
	display dialog ("Fonts: " & myFontCheck & return & "Links:" & myGraphicsCheck)
	if myFontCheck = false or myGraphicsCheck = false then
		set myPreflightCheck to false
		return myPreflightCheck
	end if
end myPreflight
on myCheckFonts(myDocument)
	tell application "Adobe InDesign 2024"
		set myFontCheck to true
		repeat with myCounter from 1 to (count fonts of myDocument)
			set myFont to font myCounter of myDocument
			if font status of myFont is not installed then
				set myFontCheck to false
				exit repeat
			end if
		end repeat
		return myFontCheck
	end tell
end myCheckFonts
on myCheckGraphics(myDocument)
	tell application "Adobe InDesign 2024"
		set myGraphicsCheck to true
		repeat with myCounter from 1 to (count graphics of myDocument)
			set myGraphic to graphic myCounter of myDocument
			set myLink to item link of myGraphic
			if link status of myLink is not normal then
				set myGraphicsCheck to false
				exit repeat
			end if
		end repeat
		return myGraphicsCheck
	end tell
end myCheckGraphics
--![Before print handler.]
