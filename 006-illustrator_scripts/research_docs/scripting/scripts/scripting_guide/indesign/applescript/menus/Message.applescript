--Message.applescript
--An InDesign AppleScript
--
--Provides a "onInvoke" event handler for MakeScriptMenuAction
--![Message.]
tell application "Adobe InDesign 2024"
	--"evt" is the event passed to this script by the event listener.
	set myEvent to evt
	display dialog "This event is the " & event type of myEvent & " event."
end tell
--![Message.]
