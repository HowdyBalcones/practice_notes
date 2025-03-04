--Message.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Provides an "afterNew" event handler for the AddEventListener.applescript 
--and MakeScriptMenuAction.applescript tutorial scripts.
--<fragment>
tell application "Adobe InCopy 2024"
	--"evt" is the event passed to this script by the event listener.
	set myEvent to evt
	display dialog "This event is the " & event type of myEvent & " event."
end tell
--</fragment>

