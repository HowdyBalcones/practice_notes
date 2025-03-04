Rem Message.vbs
Rem An InCopy VBScript
Rem
Rem Provides an "afterNew" event handler to the AddEventListener.vbs script.
Rem Displays a message when called by an event listener.
Rem "evt" is the event passed to this script by the event listener.
Rem <fragment>
MsgBox ("This event is the " & evt.EventType & " event.")
Rem </fragment>
