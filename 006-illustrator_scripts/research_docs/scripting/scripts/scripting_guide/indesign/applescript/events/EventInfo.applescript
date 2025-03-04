--EventInfo.applescript
--An InDesign AppleScript
--
--Provides a "beforeImport" event handler for the MultipleEventListeners.applescript
--tutorial script. "evt" is the event that is passed to the handler script.
--<fragment>
myEventInfoHandler(evt)
on myEventInfoHandler(myEvent)
	tell application "Adobe InDesign 2024"
		set myString to "Current Target: " & name of current target of myEvent & return
		display dialog (myString)
	end tell
end myEventInfoHandler
--</fragment>
