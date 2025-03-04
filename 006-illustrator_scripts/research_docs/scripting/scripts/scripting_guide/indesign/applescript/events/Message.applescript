--Message.applescript
--An InDesign AppleScript
--
--Provides an "afterNew" event handler for the AddEventListener.applescript
--tutorial script.
--<fragment>
tell application "Adobe InDesign 2024"
	--"evt" is the event passed to this script by the event listener.
	set myEvent to evt
	display dialog "This event is the " & event type of myEvent & " event."
end tell
--</fragment>
